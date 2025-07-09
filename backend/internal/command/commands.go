package command

import (
	"context"

	"github.com/siemasusel/tapo-apartments/generated/openapi"
	"github.com/siemasusel/tapo-apartments/internal/domain"
)

type Commands struct {
	apartAvailRepo domain.ApartmentAvailabilityRepository
	icalService    ICalService
}

func NewCommands(
	apartAvailRepo domain.ApartmentAvailabilityRepository,
	icalService ICalService,
) *Commands {
	return &Commands{
		apartAvailRepo: apartAvailRepo,
		icalService:    icalService,
	}
}

type ICalService interface {
	GetBookingUnavailableDates(ctx context.Context, slug string) ([]openapi.UnavailableDateRange, error)
}
