package main

import "testing"

func TestCamelCase(t *testing.T) {
	t.Parallel()

	tests := map[string]struct {
		input string
		upper string
		lower string
	}{
		"acronym":    {input: "CSIMountOptions", upper: "CsiMountOptions", lower: "csiMountOptions"},
		"lower":      {input: "job", upper: "Job", lower: "job"},
		"snake":      {input: "volume_mount", upper: "VolumeMount", lower: "volumeMount"},
		"whitespace": {input: " task group ", upper: "TaskGroup", lower: "taskGroup"},
	}

	for name, test := range tests {
		test := test
		t.Run(name, func(t *testing.T) {
			t.Parallel()
			if got := upperCamelCase(test.input); got != test.upper {
				t.Errorf("upperCamelCase(%q) = %q, want %q", test.input, got, test.upper)
			}
			if got := lowerCamelCase(test.input); got != test.lower {
				t.Errorf("lowerCamelCase(%q) = %q, want %q", test.input, got, test.lower)
			}
		})
	}
}

func TestPluralize(t *testing.T) {
	t.Parallel()

	for input, want := range map[string]string{
		"affinity":    "affinities",
		"network":     "networks",
		"service":     "services",
		"volumeMount": "volumeMounts",
	} {
		if got := pluralize(input); got != want {
			t.Errorf("pluralize(%q) = %q, want %q", input, got, want)
		}
	}
}
