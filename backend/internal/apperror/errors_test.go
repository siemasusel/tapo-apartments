package apperror_test

import (
	"errors"
	"testing"

	"github.com/siemasusel/tapo-apartments/internal/apperror"
)

func TestNotFound(t *testing.T) {
	err := apperror.NewNotFound(nil, "User")
	if err.Type != apperror.ErrNotFound {
		t.Errorf("expected ErrNotFound, got %s", err.Type)
	}
	if err.Error() != "NOT_FOUND: User not found" {
		t.Errorf("unexpected error message: %s", err.Error())
	}
}

func TestWrappedError(t *testing.T) {
	baseErr := errors.New("db connection failed")
	appErr := apperror.NewInternal(baseErr, "failed to connect")

	if !errors.Is(appErr, baseErr) {
		t.Error("wrapped error should match base error")
	}
	if appErr.Error() != "INTERNAL: failed to connect (db connection failed)" {
		t.Errorf("unexpected error message: %s", appErr.Error())
	}
}
