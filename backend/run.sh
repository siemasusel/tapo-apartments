#!/bin/bash
# run.sh - run app from cmd directory with env vars set

export SERVER_PORT="4445"

export SOPS_AGE_KEY_FILE="$HOME/.config/sops/age/keys.txt"
export $(sops -d secrets.enc.env | xargs)

# Change to cmd directory and run the app
cd cmd/api/ || { echo "cmd directory not found"; exit 1; }

go run .
