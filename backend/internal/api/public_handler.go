package api

import (
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/siemasusel/tapo-apartments/internal/command"
	"github.com/siemasusel/tapo-apartments/internal/query"
)

type PublicHandler struct {
	commands *command.Commands
	queries  *query.Queries
}

func (h *PublicHandler) getApartmentAvailability(c *gin.Context) {
	slug := getSlugOrAbort(c)
	if slug == "" {
		return
	}

	availability, err := h.queries.ReadApartmentAvailability(c, slug)
	if err != nil {
		handleError(c, err)
		return
	}

	if time.Since(availability.ExternalLastSyncedAt) > 15*time.Minute {
		extAvailability, err := h.commands.GenerateExternalAvailability(c, slug)
		if err != nil {
			handleError(c, err)
			return
		}

		availability.ExternalUnavailableDates = extAvailability.UnavailableDates
		availability.ExternalLastSyncedAt = extAvailability.LastSyncedAt
	}

	c.JSON(http.StatusOK, availability)
}
