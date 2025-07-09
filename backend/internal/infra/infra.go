package infra

import (
	"context"
	"log/slog"
	"net/http"
	"time"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/siemasusel/tapo-apartments/internal/ical"
)

func NewAWSConfig(ctx context.Context) aws.Config {
	cfg, err := config.LoadDefaultConfig(ctx)
	if err != nil {
		slog.Error("Failed to load AWS SDK config", slog.String("error", err.Error()))
		panic(err)
	}

	return cfg
}

func NewDynamoDBClient(cfg aws.Config, appEnv string) *dynamodb.Client {
	if appEnv == "development" {
		return dynamodb.New(dynamodb.Options{
			Credentials:      cfg.Credentials,
			Region:           "us-west-2",
			EndpointResolver: dynamodb.EndpointResolverFromURL("http://localhost:8001"),
		})
	}

	// normal client for other envs
	return dynamodb.NewFromConfig(cfg)
}

func NewICalService(cfg Config) *ical.ICalService {
	client := &http.Client{
		Timeout: 15 * time.Second,
	}

	return ical.NewICalService(
		client,
		map[string]string{
			"ola":  cfg.OlaCalendarURL,
			"ania": cfg.AniaCalendarURL,
		},
	)
}
