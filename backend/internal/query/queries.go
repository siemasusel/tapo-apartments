package query

import (
	"context"

	"github.com/siemasusel/tapo-apartments/generated/openapi"
)

type Queries struct {
	availabilityRM AvailabilityReadModel
}

func NewQueries(availabilityRM AvailabilityReadModel) *Queries {
	return &Queries{
		availabilityRM: availabilityRM,
	}
}

func (q *Queries) ReadApartmentAvailability(
	ctx context.Context,
	slug string,
) (openapi.ApartmentAvialabilityResponse, error) {
	return q.availabilityRM.ReadApartmentAvailability(ctx, slug)
}

type AvailabilityReadModel interface {
	ReadApartmentAvailability(ctx context.Context, slug string) (openapi.ApartmentAvialabilityResponse, error)
}
