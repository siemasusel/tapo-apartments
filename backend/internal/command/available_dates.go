package command

import (
	"context"

	"github.com/siemasusel/tapo-apartments/internal/domain"
)

func (c *Commands) GenerateExternalAvailability(
	ctx context.Context,
	slug string,
) (domain.ExternalAvailability, error) {
	unavailDates, err := c.icalService.GetBookingUnavailableDates(ctx, slug)
	if err != nil {
		return domain.ExternalAvailability{}, err
	}

	extAvailability := domain.NewExternalAvailability(slug, domain.AvailabilitySourceBookingcom, unavailDates)

	if err := c.apartAvailRepo.UpdateExternalAvailability(ctx, extAvailability); err != nil {
		return domain.ExternalAvailability{}, err
	}

	return extAvailability, nil
}
