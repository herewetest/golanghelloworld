package main

import (
	"testing"
)

func TestNothing(t *testing.T) {
	a := 2 + 2
	if a != 4 {
		t.Error("Well, this is interesting. The test failed")
	}
}
