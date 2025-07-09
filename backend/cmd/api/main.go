package main

import (
	"context"
	"fmt"
	"log/slog"
	"net/http"
	"os/signal"
	"syscall"
	"time"

	"github.com/siemasusel/tapo-apartments/internal/api"
	"github.com/siemasusel/tapo-apartments/internal/command"
	"github.com/siemasusel/tapo-apartments/internal/infra"
	"github.com/siemasusel/tapo-apartments/internal/query"
	"github.com/siemasusel/tapo-apartments/internal/repository"
)

func main() {
	ctx, stop := signal.NotifyContext(context.Background(), syscall.SIGINT, syscall.SIGTERM)
	defer stop()

	cfg := infra.LoadConfig()
	awsConfig := infra.NewAWSConfig(ctx)
	dbClient := infra.NewDynamoDBClient(awsConfig, cfg.AppEnv)
	icalService := infra.NewICalService(cfg)

	apartRepo := repository.NewDynamoDB(dbClient)
	commands := command.NewCommands(apartRepo, icalService)
	queries := query.NewQueries(apartRepo)

	router := api.SetupRouter(cfg, commands, queries)
	runRouter(ctx, cfg, router)
}

func runRouter(ctx context.Context, cfg infra.Config, router http.Handler) {
	srv := &http.Server{
		Addr:    fmt.Sprintf(":%s", cfg.ServerPort),
		Handler: router,
	}

	go func() {
		slog.Info("Starting HTTP server", "port", cfg.ServerPort)
		if err := srv.ListenAndServe(); err != nil && err != http.ErrServerClosed {
			slog.Error("Server failed", "error", err)
		}
	}()

	<-ctx.Done()
	slog.Info("Shutdown signal received", "reason", ctx.Err())

	shutdownCtx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	if err := srv.Shutdown(shutdownCtx); err != nil {
		slog.Error("Server Shutdown Failed", "error", err)
	} else {
		slog.Info("Server exited properly")
	}
}
