package repository

import (
	"time"

	"github.com/siemasusel/tapo-apartments/generated/openapi"
)

type ExternalAvailabilityModel struct {
	UnavailableDates []openapi.UnavailableDateRange `dynamodbav:"unavailableDates"`
	Slug             string                         `dynamodbav:"slug"`
	LastSyncedAt     time.Time                      `dynamodbav:"lastSyncedAt"`
}

type InternalAvailabilityModel struct {
	Slug            string                       `dynamodbav:"slug"`
	UnavailableDate openapi.UnavailableDateRange `dynamodbav:"unavailableDate"`
	ReservationID   string                       `dynamodbav:"reservationId"`
}
