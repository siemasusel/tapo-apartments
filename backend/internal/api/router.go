package api

import (
	"net/http"
	"slices"

	"github.com/gin-gonic/gin"
	"github.com/siemasusel/tapo-apartments/internal/apperror"
	"github.com/siemasusel/tapo-apartments/internal/command"
	"github.com/siemasusel/tapo-apartments/internal/infra"
	"github.com/siemasusel/tapo-apartments/internal/query"
)

func SetupRouter(cfg infra.Config, commands *command.Commands, queries *query.Queries) *gin.Engine {
	r := gin.Default()

	r.Handle("GET", "/health", func(gc *gin.Context) {
		gc.JSON(http.StatusOK, gin.H{"status": "UP", "message": "Service is healthy!"})
	})

	// Set up public routes under /api
	publicGroup := r.Group("/api")
	setupPublicRoutes(publicGroup, commands, queries)

	// Set up admin routes under /admin with API key middleware
	adminGroup := r.Group("/admin", apiKeyAuthMiddleware(cfg.AdminAPIKey))
	setupAdminRoutes(adminGroup, commands, queries)

	return r
}

func setupPublicRoutes(rg *gin.RouterGroup, commands *command.Commands, queries *query.Queries) {
	pubHandler := PublicHandler{
		commands: commands,
		queries:  queries,
	}

	rg.GET("/apartments/:slug/availability", pubHandler.getApartmentAvailability)
}

func setupAdminRoutes(rg *gin.RouterGroup, commands *command.Commands, queries *query.Queries) {
	adminHandler := AdminHandler{
		commands: commands,
		queries:  queries,
	}

	rg.POST("/apartments/:slug/reload-external-availability", adminHandler.reloadExternalAvailability)
}

var validSlugs = []string{"ola", "ania"}

func getSlugOrAbort(c *gin.Context) string {
	slug := c.Param("slug")
	if !slices.Contains(validSlugs, slug) {
		handleError(c, apperror.NewNotFound(nil, "apartment slug"))
		return ""
	}

	return slug
}
