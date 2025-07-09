package api

import (
	"github.com/gin-gonic/gin"
	"github.com/siemasusel/tapo-apartments/internal/apperror"
)

func apiKeyAuthMiddleware(expectedAPIKey string) gin.HandlerFunc {
	return func(c *gin.Context) {
		providedAPIKey := c.GetHeader("X-API-Key")
		if providedAPIKey != expectedAPIKey {
			handleError(c, apperror.NewUnauthorized(nil))
			return
		}
		c.Next()
	}
}
