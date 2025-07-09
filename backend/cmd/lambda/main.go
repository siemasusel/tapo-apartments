package main

import (
	"context"
	"os/signal"
	"syscall"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	ginadapter "github.com/awslabs/aws-lambda-go-api-proxy/gin"
	"github.com/gin-gonic/gin"
	"github.com/siemasusel/tapo-apartments/internal/api"
	"github.com/siemasusel/tapo-apartments/internal/command"
	"github.com/siemasusel/tapo-apartments/internal/infra"
	"github.com/siemasusel/tapo-apartments/internal/query"
	"github.com/siemasusel/tapo-apartments/internal/repository"
)

var ginLambda *ginadapter.GinLambdaV2

func init() {
	ctx, stop := signal.NotifyContext(context.Background(), syscall.SIGINT, syscall.SIGTERM)
	defer stop()

	cfg := infra.LoadConfig()
	awsConfig := infra.NewAWSConfig(ctx)
	dbClient := infra.NewDynamoDBClient(awsConfig, cfg.AppEnv)
	icalService := infra.NewICalService(cfg)

	apartRepo := repository.NewDynamoDB(dbClient)
	commands := command.NewCommands(apartRepo, icalService)
	queries := query.NewQueries(apartRepo)

	gin.SetMode(gin.ReleaseMode)
	router := api.SetupRouter(cfg, commands, queries)
	ginLambda = ginadapter.NewV2(router)
}

// Handler is the main Lambda function handler.
// It receives an APIGatewayV2HTTPRequest and returns an APIGatewayV2HTTPResponse.
// The GinLambda adapter translates these events to standard HTTP requests and responses.
func Handler(ctx context.Context, req events.APIGatewayV2HTTPRequest) (events.APIGatewayV2HTTPResponse, error) {
	// If you have specific Lambda context values you want to pass to Gin handlers,
	// you can attach them to the Gin context using middleware or `c.Set`.
	// For example, to get the request ID:
	// requestID := lambdacontext.FromContext(ctx).AwsRequestID

	// Proxy the API Gateway request to the Gin router.
	return ginLambda.ProxyWithContext(ctx, req)
}

func main() {
	lambda.Start(Handler)
}
