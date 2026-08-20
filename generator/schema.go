package main

import (
	"fmt"
	"reflect"
	"sort"
	"strings"

	"github.com/gertd/go-pluralize"
	"github.com/stoewer/go-strcase"
)

type nixSchema struct {
	types []*nixType
}

type nixType struct {
	goType  reflect.Type
	name    string
	labeled bool
	fields  []nixField
}

type nixField struct {
	goName      string
	name        string
	typeExpr    string
	defaultExpr string
	nestedType  *nixType
	container   goContainerKind
	collection  nixCollectionKind

	label bool
}

type goContainerKind uint8

const (
	goContainerSingle goContainerKind = iota
	goContainerSlice
	goContainerMap
)

type nixCollectionKind uint8

const (
	nixCollectionSingle nixCollectionKind = iota
	nixCollectionList
	nixCollectionAttrs
)

type schemaAnalyzer struct {
	pluralizer *pluralize.Client
}

type parsedHCLTag struct {
	name     string
	block    bool
	label    bool
	optional bool
}

func analyzeSchema(root reflect.Type) (*nixSchema, error) {
	analyzer := schemaAnalyzer{pluralizer: pluralize.NewClient()}
	return analyzer.analyze(root)
}

func (a schemaAnalyzer) analyze(root reflect.Type) (*nixSchema, error) {
	goTypes, err := discoverStructTypes(root)
	if err != nil {
		return nil, err
	}

	schema := &nixSchema{types: make([]*nixType, 0, len(goTypes))}
	byGoType := make(map[reflect.Type]*nixType, len(goTypes))
	byNixName := make(map[string]reflect.Type, len(goTypes))

	for _, goType := range goTypes {
		name := strcase.UpperCamelCase(goType.Name())
		if name == "" {
			return nil, fmt.Errorf("type %s has no usable Nix type name", goType)
		}
		if previous, exists := byNixName[name]; exists && previous != goType {
			return nil, fmt.Errorf("types %s and %s both map to Nix type %q", previous, goType, name)
		}

		typeModel := &nixType{
			goType:  goType,
			name:    name,
			labeled: hasLabelField(goType),
		}
		byGoType[goType] = typeModel
		byNixName[name] = goType
		schema.types = append(schema.types, typeModel)
	}

	for _, typeModel := range schema.types {
		fields, err := a.analyzeFields(typeModel.goType, byGoType)
		if err != nil {
			return nil, fmt.Errorf("analyze %s: %w", typeModel.goType, err)
		}
		typeModel.fields = fields
	}

	for _, typeModel := range schema.types {
		for i := range typeModel.fields {
			field := &typeModel.fields[i]
			if field.referencesLabeledType() && field.nestedType.labelField() == nil {
				return nil, fmt.Errorf("field %s.%s references labeled type %s without a label field", typeModel.goType, field.goName, field.nestedType.goType)
			}
		}
	}

	return schema, nil
}

func discoverStructTypes(root reflect.Type) ([]reflect.Type, error) {
	root = indirectType(root)
	if root == nil || root.Kind() != reflect.Struct {
		return nil, fmt.Errorf("root must resolve to a struct, got %v", root)
	}

	seen := make(map[reflect.Type]struct{})
	pending := []reflect.Type{root}

	for len(pending) > 0 {
		current := pending[len(pending)-1]
		pending = pending[:len(pending)-1]
		if _, exists := seen[current]; exists {
			continue
		}
		seen[current] = struct{}{}

		for _, field := range reflect.VisibleFields(current) {
			_, include := parseHCLTag(field.Tag.Get("hcl"))
			if !include {
				continue
			}

			fieldType := indirectType(field.Type)
			if fieldType != nil && fieldType.Kind() == reflect.Struct {
				pending = append(pending, fieldType)
			}
		}
	}

	types := make([]reflect.Type, 0, len(seen))
	for goType := range seen {
		types = append(types, goType)
	}
	sort.Slice(types, func(i, j int) bool {
		if types[i].Name() == types[j].Name() {
			return types[i].PkgPath() < types[j].PkgPath()
		}
		return types[i].Name() < types[j].Name()
	})

	return types, nil
}

func (a schemaAnalyzer) analyzeFields(parent reflect.Type, byGoType map[reflect.Type]*nixType) ([]nixField, error) {
	fields := make([]nixField, 0, parent.NumField())
	fieldNames := make(map[string]string)

	for _, goField := range reflect.VisibleFields(parent) {
		tag, include := parseHCLTag(goField.Tag.Get("hcl"))
		if !include {
			continue
		}

		field, err := a.analyzeField(parent, goField, tag, byGoType)
		if err != nil {
			return nil, fmt.Errorf("field %s: %w", goField.Name, err)
		}
		if previous, exists := fieldNames[field.name]; exists {
			return nil, fmt.Errorf("fields %s and %s both map to Nix option %q", previous, goField.Name, field.name)
		}
		fieldNames[field.name] = goField.Name
		fields = append(fields, field)
	}

	sort.SliceStable(fields, func(i, j int) bool {
		return fields[i].name < fields[j].name
	})
	return fields, nil
}

func (a schemaAnalyzer) analyzeField(parent reflect.Type, goField reflect.StructField, tag parsedHCLTag, byGoType map[reflect.Type]*nixType) (nixField, error) {
	field := nixField{
		goName: goField.Name,
		label:  tag.label || isJobLabel(parent, goField),
	}

	name := tag.name
	if name == "" {
		name = goField.Name
	}
	field.name = strcase.LowerCamelCase(name)
	if field.name == "" {
		return nixField{}, fmt.Errorf("tag name %q has no usable Nix option name", tag.name)
	}

	collectionType := goField.Type
	for collectionType.Kind() == reflect.Ptr {
		collectionType = collectionType.Elem()
	}
	switch collectionType.Kind() {
	case reflect.Slice:
		field.container = goContainerSlice
	case reflect.Map:
		field.container = goContainerMap
	}

	baseType := indirectType(goField.Type)
	if baseType == nil {
		return nixField{}, fmt.Errorf("type %s has no element type", goField.Type)
	}
	if tag.block && baseType.Kind() == reflect.Struct {
		field.nestedType = byGoType[baseType]
		if field.nestedType == nil {
			return nixField{}, fmt.Errorf("block type %s was not discovered", baseType)
		}
	}

	switch {
	case field.container == goContainerMap:
		field.collection = nixCollectionAttrs
	case field.container == goContainerSlice && field.referencesLabeledType():
		field.collection = nixCollectionAttrs
	case field.container == goContainerSlice:
		field.collection = nixCollectionList
	}
	if field.collection == nixCollectionList && baseType.Kind() == reflect.Struct {
		field.name = a.pluralizer.Plural(field.name)
	}
	field.typeExpr, field.defaultExpr = fieldTypeExpressions(field.collection, tag.block, tag.optional || tag.block, baseType)
	return field, nil
}

func fieldTypeExpressions(collection nixCollectionKind, block, optional bool, baseType reflect.Type) (string, string) {
	typeExpr := nixPrimitiveType(baseType)
	defaultExpr := ""

	if collection == nixCollectionAttrs {
		typeExpr = fmt.Sprintf("(attrsOf %s)", typeExpr)
		defaultExpr = "{}"
	}
	if block && defaultExpr == "" {
		defaultExpr = "{}"
	}
	if collection == nixCollectionList {
		typeExpr = fmt.Sprintf("(listOf %s)", typeExpr)
		defaultExpr = "[]"
	}
	if optional {
		typeExpr = fmt.Sprintf("(nullOr %s)", typeExpr)
		defaultExpr = "null"
	}

	return typeExpr, defaultExpr
}

func nixPrimitiveType(goType reflect.Type) string {
	switch goType.Kind() {
	case reflect.String:
		return "str"
	case reflect.Int, reflect.Int8, reflect.Int16, reflect.Int32, reflect.Int64:
		return "int"
	case reflect.Uint, reflect.Uint8, reflect.Uint16, reflect.Uint32, reflect.Uint64:
		return "ints.unsigned"
	case reflect.Bool:
		return "bool"
	case reflect.Struct:
		if name := strcase.UpperCamelCase(goType.Name()); name != "" {
			return name
		}
	}
	return "anything"
}

func indirectType(goType reflect.Type) reflect.Type {
	for goType != nil {
		switch goType.Kind() {
		case reflect.Ptr, reflect.Slice, reflect.Map:
			goType = goType.Elem()
		default:
			return goType
		}
	}
	return nil
}

func parseHCLTag(raw string) (parsedHCLTag, bool) {
	if raw == "" || raw == "-" {
		return parsedHCLTag{}, false
	}

	parts := strings.Split(raw, ",")
	tag := parsedHCLTag{name: parts[0]}
	for _, option := range parts[1:] {
		switch option {
		case "block":
			tag.block = true
		case "label":
			tag.label = true
		case "optional":
			tag.optional = true
		}
	}
	return tag, true
}

func hasLabelField(goType reflect.Type) bool {
	for _, field := range reflect.VisibleFields(goType) {
		tag, include := parseHCLTag(field.Tag.Get("hcl"))
		if include && (tag.label || isJobLabel(goType, field)) {
			return true
		}
	}
	return false
}

func isJobLabel(parent reflect.Type, field reflect.StructField) bool {
	return parent.Name() == "Job" && (field.Name == "ID" || field.Name == "Name")
}

func (t *nixType) labelField() *nixField {
	for i := range t.fields {
		if t.fields[i].label {
			return &t.fields[i]
		}
	}
	return nil
}

func (f nixField) referencesLabeledType() bool {
	return f.nestedType != nil && f.nestedType.labeled
}
