package main

import "strings"

func upperCamelCase(value string) string {
	return camelCase(value, true)
}

func lowerCamelCase(value string) string {
	return camelCase(value, false)
}

func camelCase(value string, upperFirst bool) string {
	input := []rune(strings.TrimSpace(value))
	output := make([]rune, 0, len(input))
	upperNext := upperFirst

	for index, current := range input {
		if isNameDelimiter(current) {
			upperNext = len(output) > 0 || upperFirst
			continue
		}

		var previous, next rune
		if index > 0 {
			previous = input[index-1]
		}
		if index+1 < len(input) {
			next = input[index+1]
		}

		switch {
		case len(output) == 0 && upperFirst:
			current = asciiUpper(current)
		case upperNext:
			current = asciiUpper(current)
		case asciiLower(previous):
		case asciiUppercase(previous) && asciiUppercase(current) && asciiLower(next):
		default:
			current = asciiLowercase(current)
		}

		output = append(output, current)
		upperNext = false
	}

	return string(output)
}

func pluralize(value string) string {
	if value == "" {
		return value
	}

	lower := strings.ToLower(value)
	if strings.HasSuffix(lower, "y") && len(lower) > 1 && !strings.ContainsRune("aeiou", rune(lower[len(lower)-2])) {
		return value[:len(value)-1] + "ies"
	}
	for _, suffix := range []string{"s", "x", "z", "ch", "sh"} {
		if strings.HasSuffix(lower, suffix) {
			return value + "es"
		}
	}
	return value + "s"
}

func isNameDelimiter(value rune) bool {
	return value == '-' || value == '_' || value == ' ' || value == '\t' || value == '\n' || value == '\r'
}

func asciiLower(value rune) bool {
	return value >= 'a' && value <= 'z'
}

func asciiUppercase(value rune) bool {
	return value >= 'A' && value <= 'Z'
}

func asciiLowercase(value rune) rune {
	if asciiUppercase(value) {
		return value + ('a' - 'A')
	}
	return value
}

func asciiUpper(value rune) rune {
	if asciiLower(value) {
		return value - ('a' - 'A')
	}
	return value
}
