package api

import (
	"errors"
	"log/slog"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/siemasusel/tapo-apartments/internal/apperror"
)

// HandleError handles both AppErrors and generic errors recursively.
func handleError(c *gin.Context, err error) {
	var appErr *apperror.AppError
	if errors.As(err, &appErr) {
		status := mapErrorToStatus(appErr)

		slog.Error("Handled application error",
			slog.String("type", string(appErr.Type)),
			slog.String("message", appErr.Message),
			slog.Any("error", appErr.ParentErr),
			slog.String("path", c.FullPath()),
		)

		resp := gin.H{
			"error":   string(appErr.Type),
			"message": appErr.Message,
		}
		if appErr.Type == apperror.ErrInternal {
			resp["message"] = "internal server error"
		}

		c.AbortWithStatusJSON(status, resp)
		return
	}

	// Fallback for unknown errors: wrap and recurse
	internal := apperror.NewInternal(err, "unhandled error")
	handleError(c, internal)
}

func mapErrorToStatus(err *apperror.AppError) int {
	switch err.Type {
	case apperror.ErrNotFound:
		return http.StatusNotFound
	case apperror.ErrInvalidValue:
		return http.StatusBadRequest
	case apperror.ErrUnauthorized:
		return http.StatusUnauthorized
	case apperror.ErrConflict:
		return http.StatusConflict
	case apperror.ErrInternal:
		return http.StatusInternalServerError
	default:
		return http.StatusInternalServerError
	}
}
