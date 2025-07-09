package api

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/siemasusel/tapo-apartments/generated/openapi"
	"github.com/siemasusel/tapo-apartments/internal/command"
	"github.com/siemasusel/tapo-apartments/internal/query"
)

type AdminHandler struct {
	commands *command.Commands
	queries  *query.Queries
}

func (h *AdminHandler) reloadExternalAvailability(c *gin.Context) {
	slug := getSlugOrAbort(c)
	if slug == "" {
		return
	}

	extAvailability, err := h.commands.GenerateExternalAvailability(c, slug)
	if err != nil {
		handleError(c, err)
		return
	}

	resp := openapi.ExternalAvailabilityResponse{
		Slug:             extAvailability.Slug,
		UnavailableDates: extAvailability.UnavailableDates,
		LastSyncedAt:     extAvailability.LastSyncedAt,
		Source:           string(extAvailability.Source),
	}

	c.JSON(http.StatusOK, resp)
}
