package main

import (
	"fmt"
	"github.com/gertd/go-pluralize"
	"github.com/hashicorp/nomad/api"
	"github.com/iancoleman/strcase"
	"reflect"
	"sort"
	"strings"
)

type NomadType struct {
	goName string

	nixTypeName      string
	nixTransformName string

	label      *NomadField
	references []NomadType
	fields     []NomadField
}

type NomadField struct {
	goName string
	goType reflect.Type

	nixName    string
	nixType    string
	nixDefault string

	nomadType *NomadType

	isStruct  bool
	isBlock   bool
	isLabel   bool
	isLabeled bool
	isMap     bool
	isList    bool

	isOptional bool
	label      *NomadField
}

func main() {
	job := reflect.TypeOf(api.Job{})
	fmt.Printf("{ lib, overrides, ... }:\n\n")
	fmt.Printf("rec {\n")
	for _, t := range findAllTypes(job) {
		nt := parseNomadType(t)
		fmt.Printf("  %s = %s;\n", nt.nixTypeName, strings.TrimSpace(indent(generateTypeModule(nt), 4)))
		fmt.Printf("\n")
	}
	for _, t := range findAllTypes(job) {
		nt := parseNomadType(t)
		fmt.Printf("  %s = %s;\n", nt.nixTransformName, strings.TrimSpace(indent(generateTransformer(nt), 2)))
		fmt.Printf("\n")
	}
	fmt.Printf("}\n")
}

func generateTypeModule(t *NomadType) string {
	var o string

	o += fmt.Sprintf("lib.types.submodule ({ lib, ... }:\n")
	if len(t.references) > 0 {
		var s []string
		for _, rt := range t.references {
			s = append(s, rt.nixTypeName)
		}
	}
	o += fmt.Sprintf("with lib.types; {\n")

	for _, f := range t.fields {
		if f.isLabel {
			continue
		}
		o += fmt.Sprintf("  options.%s = lib.mkOption ({\n", f.nixName)
		o += fmt.Sprintf("    type = %s;\n", f.nixType)
		if f.nixDefault != "" {
			o += fmt.Sprintf("    default = %s;\n", f.nixDefault)
		}
		o += fmt.Sprintf("  } // ((overrides.%s or {}).%s or {}));\n", t.nixTypeName, f.nixName)
	}
	o += fmt.Sprintf("})")

	return o
}

func generateTransformer(t *NomadType) string {
	var o string

	o += fmt.Sprintf("attrs: if !(builtins.isAttrs attrs) then null else (\n")
	o += fmt.Sprintf("  {}\n")
	for _, f := range t.fields {
		if f.isLabel {
			continue
		}

		if f.isLabeled {
			o += fmt.Sprintf("  // (if attrs ? %s && builtins.isAttrs attrs.%s then ", f.nixName, f.nixName)
			o += fmt.Sprintf("{ %s = lib.mapAttrsToList (k: v: (%s (v // { %s = k; }))) attrs.%s; }", f.goName, f.nomadType.nixTransformName, f.nomadType.label.goName, f.nixName)
			o += fmt.Sprintf(" else {})\n")
			continue
		}

		if f.isList && f.nomadType != nil {
			o += fmt.Sprintf("  // (if attrs ? %s && builtins.isList attrs.%s then", f.nixName, f.nixName)
			o += fmt.Sprintf(" { %s = builtins.map %s (attrs.%s or []); }", f.goName, f.nomadType.nixTransformName, f.nixName)
			o += fmt.Sprintf(" else {})\n")
			continue
		}

		if f.nomadType != nil {
			o += fmt.Sprintf("  // (if attrs ? %s then", f.nixName)
			o += fmt.Sprintf(" { %s = %s attrs.%s; }", f.goName, f.nomadType.nixTransformName, f.nixName)
			o += fmt.Sprintf(" else {})\n")

			continue
		}

		o += fmt.Sprintf("  // (if attrs ? %s then", f.nixName)
		o += fmt.Sprintf(" { %s = attrs.%s; }", f.goName, f.nixName)
		o += fmt.Sprintf(" else {})\n")
	}
	o += fmt.Sprintf(")")

	return o
}

func parseNomadType(t reflect.Type) *NomadType {
	o := NomadType{
		goName:           t.Name(),
		nixTypeName:      strcase.ToCamel(t.Name()),
		nixTransformName: strcase.ToLowerCamel("mk" + t.Name() + "API"),
	}

	for _, rt := range collectReferencedTypes(t) {
		o.references = append(o.references, *parseNomadType(rt))
	}

	for _, f := range reflect.VisibleFields(t) {
		nf := parseNomadField(f)
		if nf == nil {
			continue
		}
		if nf.isLabel {
			o.label = nf
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

func parseNomadField(f reflect.StructField) *NomadField {
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
	o.isMap = false
	o.isList = false

	if o.isBlock {
		o.isOptional = true
	}

	if f.Type.Kind() == reflect.Slice {
		if o.isLabeled {
			o.isMap = true
		} else {
			o.isList = true
		}
	} else if f.Type.Kind() == reflect.Map {
		o.isMap = true
	}

	o.nixName = strcase.ToLowerCamel(hclParts[0])
	o.nixType = o.goType.Name()
	o.nixDefault = ""

	if o.nixType == "" {
		o.nixType = "anything"
	}

	if o.goType.Kind() == reflect.String {
		o.nixType = "str"
	} else if o.goType.Kind() == reflect.Int8 {
		o.nixType = "int"
	} else if o.goType.Kind() == reflect.Int16 {
		o.nixType = "int"
	} else if o.goType.Kind() == reflect.Int32 {
		o.nixType = "int"
	} else if o.goType.Kind() == reflect.Int64 {
		o.nixType = "int"
	} else if o.goType.Kind() == reflect.Uint8 {
		o.nixType = "ints.unsigned"
	} else if o.goType.Kind() == reflect.Uint16 {
		o.nixType = "ints.unsigned"
	} else if o.goType.Kind() == reflect.Uint32 {
		o.nixType = "ints.unsigned"
	} else if o.goType.Kind() == reflect.Uint64 {
		o.nixType = "ints.unsigned"
	}

	if (o.isMap || o.isList) && o.goType.Kind() == reflect.Struct {
		o.nixName = pluralize.NewClient().Plural(o.nixName)
		o.nixType = strcase.ToCamel(o.nixType)
	}
	if o.isMap {
		o.nixType = fmt.Sprintf("(attrsOf %s)", o.nixType)
	}
	if o.isMap || o.isBlock {
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
