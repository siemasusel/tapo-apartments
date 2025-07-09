package apperror

import (
	"errors"
	"fmt"
)

// AppError is a custom application error type.
type AppError struct {
	Type      ErrorType
	Message   string
	ParentErr error
}

func (e *AppError) Error() string {
	if e.ParentErr != nil {
		return fmt.Sprintf("%s: %s (%v)", e.Type, e.Message, e.ParentErr)
	}
	return fmt.Sprintf("%s: %s", e.Type, e.Message)
}

func (e *AppError) Unwrap() error {
	return e.ParentErr
}

func newAppError(err error, errType ErrorType, message string) *AppError {
	return &AppError{
		Type:      errType,
		Message:   message,
		ParentErr: err,
	}
}

// Convenience constructors

func NewNotFound(err error, entity string) *AppError {
	return newAppError(err, ErrNotFound, fmt.Sprintf("%s not found", entity))
}

func NewInvalidValue(err error, field string) *AppError {
	return newAppError(err, ErrInvalidValue, fmt.Sprintf("invalid value for %s", field))
}

func NewUnauthorized(err error) *AppError {
	return newAppError(err, ErrUnauthorized, "unauthorized")
}

func NewConflict(err error, resource string) *AppError {
	return newAppError(err, ErrConflict, fmt.Sprintf("%s conflict", resource))
}

func NewInternal(err error, message string) *AppError {
	return newAppError(err, ErrInternal, message)
}

// Helper checkers

func IsNotFound(err error) bool {
	var appErr *AppError
	if errors.As(err, &appErr) {
		return appErr.Type == ErrNotFound
	}
	return false
}

func IsInvalidValue(err error) bool {
	var appErr *AppError
	if errors.As(err, &appErr) {
		return appErr.Type == ErrInvalidValue
	}
	return false
}

func IsUnauthorized(err error) bool {
	var appErr *AppError
	if errors.As(err, &appErr) {
		return appErr.Type == ErrUnauthorized
	}
	return false
}

func IsConflict(err error) bool {
	var appErr *AppError
	if errors.As(err, &appErr) {
		return appErr.Type == ErrConflict
	}
	return false
}

func IsInternal(err error) bool {
	var appErr *AppError
	if errors.As(err, &appErr) {
		return appErr.Type == ErrInternal
	}
	return false
}
