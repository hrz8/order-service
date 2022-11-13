package helpers

import (
	"testing"
)

// TestAdd calls helpers.Add with a input number
func TestAdd(t *testing.T) {
	a := 1
	b := 2
	expected := 3
	result := Add(a, b)
	if result != expected {
		t.Fatalf(`Add(1, 2) = %v, should be %v`, result, expected)
	}
}
