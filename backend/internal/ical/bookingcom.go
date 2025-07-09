package ical

import (
	"context"
	"fmt"
	"net/http"

	ics "github.com/arran4/golang-ical"
	"github.com/siemasusel/tapo-apartments/generated/openapi"
)

type ICalService struct {
	client       *http.Client
	slugToCalURL map[string]string
}

func NewICalService(client *http.Client, slugToCalURL map[string]string) *ICalService {
	return &ICalService{client, slugToCalURL}
}

func (i *ICalService) GetBookingUnavailableDates(
	ctx context.Context,
	slug string,
) ([]openapi.UnavailableDateRange, error) {
	calURL, ok := i.slugToCalURL[slug]
	if !ok {
		return nil, fmt.Errorf("no calendar url for slug '%s'", slug)
	}

	cal, err := ics.ParseCalendarFromUrl(calURL, ctx, i.client)
	if err != nil {
		return nil, fmt.Errorf("failed to parse calendar url: %w", err)
	}

	res := make([]openapi.UnavailableDateRange, 0, len(cal.Events()))
	for _, event := range cal.Events() {
		startedAt, err := event.GetStartAt()
		if err != nil {
			return nil, fmt.Errorf("failed to parse startedAt %w", err)
		}

		endedAt, err := event.GetEndAt()
		if err != nil {
			return nil, fmt.Errorf("failed to parse endedAt %w", err)
		}

		// Adjust for exclusive DTEND
		endedAt = endedAt.AddDate(0, 0, -1)

		res = append(res, openapi.UnavailableDateRange{
			StartDate: startedAt.Format("2006-01-02"),
			EndDate:   endedAt.Format("2006-01-02"),
			Source:    "bookingcom",
		})
	}

	return res, nil
}
