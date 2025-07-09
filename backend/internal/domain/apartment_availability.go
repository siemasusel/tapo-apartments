package domain

import (
	"context"
	"time"

	"github.com/siemasusel/tapo-apartments/generated/openapi"
)

type ExternalAvailability struct {
	Slug             string
	UnavailableDates []openapi.UnavailableDateRange
	LastSyncedAt     time.Time
	Source           AvailabilitySource
}

type AvailabilitySource string

const (
	AvailabilitySourceBookingcom = "bookingcom"
	AvailabilitySourceWebsite    = "website"
)

func NewExternalAvailability(
	slug string,
	source AvailabilitySource,
	unavailableDates []openapi.UnavailableDateRange,
) ExternalAvailability {
	return ExternalAvailability{
		Slug:             slug,
		UnavailableDates: unavailableDates,
		LastSyncedAt:     time.Now(),
		Source:           source,
	}
}

type ApartmentAvailabilityRepository interface {
	UpdateExternalAvailability(ctx context.Context, extAvailability ExternalAvailability) error
}
