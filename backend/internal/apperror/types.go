package apperror

// ErrorType is a string alias for error classification.
type ErrorType string

const (
	ErrNotFound     ErrorType = "NOT_FOUND"
	ErrInvalidValue ErrorType = "INVALID_VALUE"
	ErrUnauthorized ErrorType = "UNAUTHORIZED"
	ErrConflict     ErrorType = "CONFLICT"
	ErrInternal     ErrorType = "INTERNAL"
)
