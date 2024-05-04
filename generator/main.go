package main

import (
	"fmt"
	"github.com/gertd/go-pluralize"
	"github.com/hashicorp/nomad/api"
	"github.com/stoewer/go-strcase"
	"reflect"
	"sort"
	"strings"
)

type NomadType struct {
	goName string

	nixTypeName      string
	nixTransformName string

	isLabeled  bool
	references []NomadType
	fields     []NomadField
}

type NomadField struct {
	goName string
	goType reflect.Type

	hclName string

	nixName    string
	nixType    string
	nixDefault string

	nomadType *NomadType

	isStruct  bool
	isBlock   bool
	isLabel   bool
	isLabeled bool
	isSlice   bool
	isMap     bool

	isAttrs bool
	isList  bool

	isOptional bool
	label      *NomadField
}

func main() {
	job := api.Job{}
	jobType := reflect.TypeOf(job)

	fmt.Printf("{ config, lib, ... }:\n\n")
	fmt.Printf("{\n")
	for _, t := range findAllTypes(jobType) {
		nt := parseNomadType(t)
		fmt.Printf("  _module.types.%s = with lib; with config._module.types; %s;\n", nt.nixTypeName, strings.TrimSpace(indent(generateTypeModule(nt), 2)))
	}
	for _, t := range findAllTypes(jobType) {
		nt := parseNomadType(t)
		fmt.Printf("\n")
		fmt.Printf("  # Convert a %s Nix module into a JSON object.\n", nt.nixTypeName)
		fmt.Printf("  _module.transformers.%s.toJSON = with lib; with config._module.transformers; %s;\n", nt.nixTypeName, strings.TrimSpace(indent(genStructToJson(nt), 2)))
		fmt.Printf("\n")
		fmt.Printf("  # Convert a %s JSON object into a Nix module.\n", nt.nixTypeName)
		fmt.Printf("  _module.transformers.%s.fromJSON = with lib; with config._module.transformers; %s;\n", nt.nixTypeName, strings.TrimSpace(indent(genStructFromJson(nt), 2)))
	}
	fmt.Printf("}\n")
}

func generateTypeModule(t *NomadType) string {
	var o string

	if t.isLabeled {
		o += fmt.Sprintf("with lib.types; submodule ({ name, ... }: {\n")
	} else {
		o += fmt.Sprintf("with lib.types; submodule ({\n")
	}

	for _, f := range t.fields {
		o += fmt.Sprintf("  options.%s = mkOption {\n", f.nixName)
		o += fmt.Sprintf("    type = %s;\n", f.nixType)
		if f.isLabel {
			o += fmt.Sprintf("    default = name;\n")
			o += fmt.Sprintf("    internal = true;\n")
			o += fmt.Sprintf("    visible = false;\n")
		} else if f.nixDefault != "" {
			o += fmt.Sprintf("    default = %s;\n", f.nixDefault)
		}
		o += fmt.Sprintf("  };\n")
	}
	o += fmt.Sprintf("})")

	return o
}

func genStructToJson(t *NomadType) string {
	var o string

	o += fmt.Sprintf("attrs: if !(builtins.isAttrs attrs) then null else (\n")
	o += fmt.Sprintf("  {}\n")
	for _, f := range t.fields {
		o += fmt.Sprintf("  // (%s)\n", genFieldToJson(f))
	}

	o += fmt.Sprintf(")")

	return o
}

func genFieldToJson(f NomadField) string {
	if f.isLabeled && f.isSlice {
		return fmt.Sprintf(""+
			"if attrs ? %s && builtins.isAttrs attrs.%s "+
			"then { %s = mapAttrsToList (_: %s.toJSON) attrs.%s; } "+
			"else {}",
			f.nixName,
			f.nixName,
			f.goName,
			f.nomadType.nixTypeName,
			f.nixName,
		)
	}

	if f.isLabeled && f.isMap {
		return fmt.Sprintf(""+
			"if attrs ? %s && builtins.isAttrs attrs.%s "+
			"then { %s = mapAttrs (_: %s.toJSON) attrs.%s; } "+
			"else {}",
			f.nixName,
			f.nixName,
			f.goName,
			f.nomadType.nixTypeName,
			f.nixName,
		)
	}

	if f.isList && f.nomadType != nil {
		return fmt.Sprintf(""+
			"if attrs ? %s && builtins.isList attrs.%s then { %s = builtins.map %s.toJSON attrs.%s; } else {}",
			f.nixName,
			f.nixName,
			f.goName,
			f.nomadType.nixTypeName,
			f.nixName,
		)
	}

	if f.nomadType != nil {
		return fmt.Sprintf(
			"if attrs ? %s && attrs.%s != null then { %s = %s.toJSON attrs.%s; } else {}",
			f.nixName,
			f.nixName,
			f.goName,
			f.nomadType.nixTypeName,
			f.nixName,
		)
	}

	return fmt.Sprintf(
		"if attrs ? %s && attrs.%s != null then { %s = attrs.%s; } else {}",
		f.nixName,
		f.nixName,
		f.goName,
		f.nixName,
	)
}

func genStructFromJson(t *NomadType) string {
	var o string

	o += fmt.Sprintf("attrs: (\n")
	o += fmt.Sprintf("  {}\n")
	for _, f := range t.fields {
		o += fmt.Sprintf("  // (%s)\n", genFieldFromJson(f))
	}

	o += fmt.Sprintf(")")

	return o
}

func genFieldFromJson(f NomadField) string {
	if f.isLabeled {
		var label NomadField
		for _, field := range f.nomadType.fields {
			if field.isLabel {
				label = field
				break
			}
		}

		return fmt.Sprintf(""+
			"if attrs ? %s && builtins.isList attrs.%s "+
			"then { %s = builtins.listToAttrs (builtins.map (v: nameValuePair v.%s (%s.fromJSON v)) attrs.%s); } "+
			"else {}",
			f.goName,
			f.goName,
			f.nixName,
			label.goName,
			f.nomadType.nixTypeName,
			f.goName,
		)
	}

	if f.isList && f.nomadType != nil {
		return fmt.Sprintf(""+
			"if attrs ? %s && builtins.isList attrs.%s then { %s = builtins.map %s.fromJSON attrs.%s; } else {}",
			f.goName,
			f.goName,
			f.nixName,
			f.nomadType.nixTypeName,
			f.goName,
		)
	}

	if f.nomadType != nil {
		return fmt.Sprintf(
			"if attrs ? %s && attrs.%s != null then { %s = %s.fromJSON attrs.%s; } else {}",
			f.goName,
			f.goName,
			f.nixName,
			f.nomadType.nixTypeName,
			f.goName,
		)
	}

	return fmt.Sprintf(
		"if attrs ? %s && attrs.%s != null then { %s = attrs.%s; } else {}",
		f.goName,
		f.goName,
		f.nixName,
		f.goName,
	)
}

func parseNomadType(t reflect.Type) *NomadType {
	o := NomadType{
		goName:           t.Name(),
		nixTypeName:      strcase.UpperCamelCase(t.Name()),
		nixTransformName: "toJSON",
	}

	for _, rt := range collectReferencedTypes(t) {
		o.references = append(o.references, *parseNomadType(rt))
	}

	for _, f := range reflect.VisibleFields(t) {
		nf := parseNomadField(t, f)

		// Job ID/Name are specially handled in the Nomad code, so we have to manually set them as labels
		if t.Name() == "Job" && (f.Name == "ID" || f.Name == "Name") {
			nf.isLabel = true
		}
		if nf == nil {
			continue
		}
		if nf.isLabel {
			o.isLabeled = true
		}
		o.fields = append(o.fields, *nf)
	}

	sort.SliceStable(o.references, func(i, j int) bool {
		return o.references[i].nixTypeName < o.references[j].nixTypeName
	})
	sort.SliceStable(o.fields, func(i, j int) bool {
		return o.fields[i].nixName < o.fields[j].nixName
	})

	return &o
}

func parseNomadField(t reflect.Type, f reflect.StructField) *NomadField {
	hcl := f.Tag.Get("hcl")

	if hcl == "" {
		return nil
	}

	hclParts := strings.Split(hcl, ",")

	o := NomadField{
		goName: f.Name,
		goType: f.Type,
	}

	if len(hclParts) > 1 && hclParts[1] == "label" {
		o.isLabel = true
	}

	for o.goType.Kind() == reflect.Ptr || o.goType.Kind() == reflect.Slice || o.goType.Kind() == reflect.Map {
		o.goType = o.goType.Elem()
	}

	o.isStruct = o.goType.Kind() == reflect.Struct
	o.isBlock = len(hclParts) > 1 && hclParts[1] == "block"
	if o.isStruct && o.isBlock {
		o.isLabeled = hasLabelField(o.goType)
		o.nomadType = parseNomadType(o.goType)
	}
	o.isOptional = len(hclParts) > 1 && hclParts[1] == "optional"
	o.isSlice = false
	o.isAttrs = false
	o.isList = false

	if o.isBlock {
		o.isOptional = true
	}

	if f.Type.Kind() == reflect.Slice {
		o.isSlice = true
		if o.isLabeled {
			o.isAttrs = true
		} else {
			o.isList = true
		}
	} else if f.Type.Kind() == reflect.Map {
		o.isMap = true
		o.isAttrs = true
	}

	o.hclName = hclParts[0]
	o.nixName = strcase.LowerCamelCase(hclParts[0])
	o.nixType = o.goType.Name()
	o.nixDefault = ""

	if o.nixType == "" {
		o.nixType = "anything"
	}

	switch o.goType.Kind() {
		case reflect.String:
			o.nixType = "str"
		case reflect.Int, reflect.Int8, reflect.Int16, reflect.Int32, reflect.Int64:
			o.nixType = "int"
		case reflect.Uint8, reflect.Uint16, reflect.Uint32, reflect.Uint64:
			o.nixType = "ints.unsigned"
		case reflect.Bool:
			o.nixType = "bool"
		case reflect.Struct:
			o.nixType = strcase.UpperCamelCase(o.goType.Name())
		default:
			o.nixType = "anything"
	}

	//if o.nomadType != nil {
	//	o.nixType = fmt.Sprintf("(submodule %s)", o.nixType)
	//}

	if o.isList && o.goType.Kind() == reflect.Struct {
		o.nixName = pluralize.NewClient().Plural(o.nixName)
	}
	if o.isAttrs {
		o.nixType = fmt.Sprintf("(attrsOf %s)", o.nixType)
	}
	if o.isAttrs || o.isBlock {
		o.nixDefault = "{}"
	}
	if o.isList {
		o.nixType = fmt.Sprintf("(listOf %s)", o.nixType)
		o.nixDefault = "[]"
	}
	if o.isOptional {
		o.nixType = fmt.Sprintf("(nullOr %s)", o.nixType)
		o.nixDefault = "null"
	}

	if o.isLabel && o.nixName == "" {
		o.nixName = strcase.LowerCamelCase(o.goName)
	}

	return &o
}

func hasLabelField(t reflect.Type) bool {
	for _, field := range reflect.VisibleFields(t) {
		hcl := field.Tag.Get("hcl")

		if hcl == "" {
			continue
		}

		hclParts := strings.Split(hcl, ",")
		if len(hclParts) > 1 && hclParts[1] == "label" {
			return true
		}
	}

	return false
}

func collectReferencedTypes(t reflect.Type) []reflect.Type {
	m := map[reflect.Type]bool{}
	for _, field := range reflect.VisibleFields(t) {
		hcl := field.Tag.Get("hcl")

		if hcl == "" {
			continue
		}

		elemType := field.Type
		for elemType.Kind() == reflect.Ptr || elemType.Kind() == reflect.Slice || elemType.Kind() == reflect.Map {
			elemType = elemType.Elem()
		}

		if elemType.Kind() == reflect.Struct {
			m[elemType] = true
		}
	}

	i := 0
	types := make([]reflect.Type, len(m))
	for k, _ := range m {
		types[i] = k
		i++
	}
	return types
}

func findAllTypes(root reflect.Type) []reflect.Type {
	m := map[reflect.Type]bool{}
	m[root] = true
	for _, field := range reflect.VisibleFields(root) {
		hcl := field.Tag.Get("hcl")

		if hcl == "" {
			continue
		}

		elemType := field.Type
		for elemType.Kind() == reflect.Ptr || elemType.Kind() == reflect.Slice || elemType.Kind() == reflect.Map {
			elemType = elemType.Elem()
		}

		if elemType.Kind() == reflect.Struct {
			if _, ok := m[elemType]; ok {
				continue
			}

			m[elemType] = true

			for _, rt := range findAllTypes(elemType) {
				m[rt] = true
			}
		}
	}

	i := 0
	types := make([]reflect.Type, len(m))
	for k, _ := range m {
		types[i] = k
		i++
	}

	sort.Slice(types, func(i, j int) bool {
		return types[i].Name() < types[j].Name()
	})

	return types
}

func indent(s string, n int) string {
	p := strings.Split(s, "\n")
	for i, v := range p {
		p[i] = strings.Repeat(" ", n) + v
	}
	return strings.Join(p, "\n")
}
