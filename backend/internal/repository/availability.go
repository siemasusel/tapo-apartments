package repository

import (
	"context"
	"fmt"
	"log/slog"
	"strings"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/feature/dynamodb/attributevalue"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
	"github.com/siemasusel/tapo-apartments/generated/openapi"
	"github.com/siemasusel/tapo-apartments/internal/domain"
)

func (d *DynamoDB) UpdateExternalAvailability(
	ctx context.Context,
	extAvailability domain.ExternalAvailability,
) error {
	item := ExternalAvailabilityModel{
		Slug:             extAvailability.Slug,
		UnavailableDates: extAvailability.UnavailableDates,
		LastSyncedAt:     extAvailability.LastSyncedAt,
	}

	avMap, err := attributevalue.MarshalMap(item)
	if err != nil {
		return fmt.Errorf("failed to marshal external availability: %w", err)
	}

	// Add key attributes explicitly if not part of item
	avMap["PK"] = &types.AttributeValueMemberS{Value: fmt.Sprintf("APT#%s", extAvailability.Slug)}
	avMap["SK"] = &types.AttributeValueMemberS{Value: "AVAILABILITY#EXT"}

	_, err = d.client.PutItem(ctx, &dynamodb.PutItemInput{
		TableName: aws.String(tableName),
		Item:      avMap,
	})
	if err != nil {
		return fmt.Errorf("failed to put item to DynamoDB: %w", err)
	}

	return nil
}

func (d *DynamoDB) addInternalAvailability(
	ctx context.Context,
	slug, reservationID string,
	unavailableDate openapi.UnavailableDateRange,
) error {
	item := InternalAvailabilityModel{
		Slug:            slug,
		ReservationID:   reservationID,
		UnavailableDate: unavailableDate,
	}

	avMap, err := attributevalue.MarshalMap(item)
	if err != nil {
		return fmt.Errorf("failed to marshal internal availability: %w", err)
	}

	// Add key attributes explicitly if not part of item
	avMap["PK"] = &types.AttributeValueMemberS{Value: fmt.Sprintf("APT#%s", slug)}
	avMap["SK"] = &types.AttributeValueMemberS{Value: fmt.Sprintf("AVAILABILITY#IN#%s", reservationID)}

	_, err = d.client.PutItem(ctx, &dynamodb.PutItemInput{
		TableName: aws.String(tableName),
		Item:      avMap,
	})
	if err != nil {
		return fmt.Errorf("failed to put item to DynamoDB: %w", err)
	}

	return nil
}

func (d *DynamoDB) ReadApartmentAvailability(
	ctx context.Context,
	slug string,
) (openapi.ApartmentAvialabilityResponse, error) {
	pk := fmt.Sprintf("APT#%s", slug)

	// Query all items with the same partition key
	output, err := d.client.Query(ctx, &dynamodb.QueryInput{
		TableName:              aws.String(tableName),
		KeyConditionExpression: aws.String("PK = :pk AND begins_with(SK, :skPrefix)"),
		ExpressionAttributeValues: map[string]types.AttributeValue{
			":pk":       &types.AttributeValueMemberS{Value: pk},
			":skPrefix": &types.AttributeValueMemberS{Value: "AVAILABILITY#"},
		},
	})
	if err != nil {
		return openapi.ApartmentAvialabilityResponse{}, fmt.Errorf("failed to query: %w", err)
	}

	resp := openapi.ApartmentAvialabilityResponse{
		Slug:                     slug,
		ExternalUnavailableDates: make([]openapi.UnavailableDateRange, 0),
		InternalUnavailableDates: make([]openapi.UnavailableDateRange, 0),
	}
	// Distinguish between external and internal records
	for _, item := range output.Items {
		skAttr, ok := item["SK"]
		if !ok {
			return resp, fmt.Errorf("item missing 'sk' attribute: %+v", item)
		}

		sk := skAttr.(*types.AttributeValueMemberS).Value
		switch {
		case sk == "AVAILABILITY#EXT":
			var ext ExternalAvailabilityModel
			if err := attributevalue.UnmarshalMap(item, &ext); err != nil {
				slog.Error("Failed to unmarshal external availability",
					slog.Any("error", err),
					slog.String("sk", sk),
					slog.Any("item", item),
				)
				return resp, fmt.Errorf("failed to unmarshal external availability: %w", err)
			}
			resp.ExternalLastSyncedAt = ext.LastSyncedAt
			resp.ExternalUnavailableDates = ext.UnavailableDates

		case strings.HasPrefix(sk, "AVAILABILITY#IN#"):
			var in InternalAvailabilityModel
			if err := attributevalue.UnmarshalMap(item, &in); err != nil {
				slog.Error("Failed to unmarshal internal availability",
					slog.Any("error", err),
					slog.String("sk", sk),
					slog.Any("item", item),
				)
				return resp, fmt.Errorf("failed to unmarshal internal availability: %w", err)
			}
			resp.InternalUnavailableDates = append(resp.InternalUnavailableDates, in.UnavailableDate)
		default:
			return resp, fmt.Errorf("unexpected sk format: %s", sk)
		}
	}

	return resp, nil
}
