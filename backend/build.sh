#!/bin/bash

set -e  # Exit on error

# Move to the backend directory (adjust if your structure is different)
echo "🔨 Building Go Lambda binary..."

# Ensure .build directory exists
mkdir -p .build

# Compile the Go Lambda binary for Linux (required by AWS Lambda)
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o .build/bootstrap ./cmd/lambda

echo "✅ Go binary built: .build/bootstrap"

