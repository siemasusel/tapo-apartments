package infra

import (
	"log/slog"
	"os"

	"github.com/kelseyhightower/envconfig"
)

type Config struct {
	AppEnv     string `envconfig:"APP_ENV"     default:"development"`
	ServerPort string `envconfig:"SERVER_PORT" default:"8080"`

	OlaCalendarURL  string `envconfig:"OLA_CALENDAR_URL"  required:"true"`
	AniaCalendarURL string `envconfig:"ANIA_CALENDAR_URL" required:"true"`

	AdminAPIKey string `envconfig:"ADMIN_API_KEY" required:"true"`
}

func LoadConfig() Config {
	var cfg Config
	if err := envconfig.Process("TAPO", &cfg); err != nil {
		slog.Error("Failed to load environment config", "error", err)
		os.Exit(1)
	}

	return cfg
}
