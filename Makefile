# Makefile at project root

# AWS settings
AWS_PROFILE=tapo-apartamenty
S3_BUCKET=tapo-apartamenty-static-site-021775ea
CLOUDFRONT_DIST_ID=E1BBYT6BYFTRTR

# OpenAPI Generator settings
OPENAPI_SPEC := backend/openapi.yml
OUTPUT_DIR := generated
GENERATOR_NAME := go-gin-server
DOCKER_IMAGE := openapitools/openapi-generator-cli:latest # You can pin a specific version like 7.5.0

# Docker compose settings
COMPOSE_DIR = backend
COMPOSE_FILE = $(COMPOSE_DIR)/docker-compose.yml
DYNAMODB_ENDPOINT = http://localhost:8001
TABLE_NAME = ApartmentsData

.PHONY: all sync invalidate deploy-frontend terraform terraform-plan build-frontend run-frontend build-backend run-backend generate clean_generated_dir clean help

# Default action
all: deploy

# Build the frontend
build-frontend:
	cd frontend && npm run build

# Run local dev server
run-frontend:
	cd frontend && npm run dev -- --open

build-backend:
	cd backend && ./build.sh

run-backend: init-dynamodb
	cd backend && ./run.sh

# Sync build to S3
sync:
	aws --profile $(AWS_PROFILE) s3 sync ./frontend/build/ s3://$(S3_BUCKET) --delete

# Invalidate CloudFront cache
invalidate:
	aws cloudfront --profile $(AWS_PROFILE) create-invalidation \
		--distribution-id $(CLOUDFRONT_DIST_ID) \
		--paths "/*"

# Full deployment (build + sync + invalidate)
deploy-frontend: build-frontend sync invalidate

# Decrypt and plan Terraform with env secrets for ALL modules
.PHONY: terraform-plan
terraform-plan:
	@echo "Decrypting secrets..."
	@export $$(SOPS_AGE_KEY_FILE=$(HOME)/.config/sops/age/keys.txt sops -d backend/secrets.enc.env | xargs) && \
	cd terraform && \
	terraform plan \
		-var="tapo_ola_calendar_url=$${TAPO_OLA_CALENDAR_URL}" \
		-var="tapo_ania_calendar_url=$${TAPO_ANIA_CALENDAR_URL}" \
		-var="tapo_admin_api_key=$${TAPO_ADMIN_API_KEY}"

# Decrypt and apply Terraform for ONLY the backend module
.PHONY: terraform-apply
terraform-apply:
	@echo "Decrypting secrets..."
	@export $$(SOPS_AGE_KEY_FILE=$(HOME)/.config/sops/age/keys.txt sops -d backend/secrets.enc.env | xargs) && \
	cd terraform && \
	terraform apply \
		-var="tapo_ola_calendar_url=$${TAPO_OLA_CALENDAR_URL}" \
		-var="tapo_ania_calendar_url=$${TAPO_ANIA_CALENDAR_URL}" \
		-var="tapo_admin_api_key=$${TAPO_ADMIN_API_KEY}"


# Generate Go structures from OpenAPI spec using Docker
# This command will pull and run the openapitools/openapi-generator-cli Docker image.
# It mounts the openapi.yml file as input and the generated output directory.
.PHONY: openapi-generate
openapi-generate:
	@echo "Generating Go OpenAPI structures using Docker..."
	@mkdir -p backend/generated/openapi # Ensure output directory exists
	docker run --rm \
		-v "$(PWD)/backend/openapi.yml:/local/openapi.yml:ro" \
		-v "$(PWD)/backend/generated/openapi:/local/generated:rw" \
		openapitools/openapi-generator-cli generate \
		-g go \
		--skip-validate-spec \
		--global-property models,supportingFiles \
		--additional-properties=withGoMod=false \
		-i /local/openapi.yml \
		-o /local/generated

# Clean up generated OpenAPI files
.PHONY: clean-openapi
clean-openapi:
	@echo "Cleaning up generated OpenAPI files..."
	@rm -rf backend/generated/openapi/


.PHONY: start-dynamodb
start-dynamodb:
	docker-compose -f $(COMPOSE_FILE) up -d dynamodb-local

.PHONY: create-table
create-table:
	@if aws --endpoint-url $(DYNAMODB_ENDPOINT) dynamodb describe-table --table-name $(TABLE_NAME) > /dev/null 2>&1; then \
		echo "Table $(TABLE_NAME) already exists, skipping creation."; \
	else \
		echo "Creating table $(TABLE_NAME)..."; \
		docker run --rm \
			--network host \
			-e AWS_ACCESS_KEY_ID=dummy \
			-e AWS_SECRET_ACCESS_KEY=dummy \
			amazon/aws-cli dynamodb create-table \
			--table-name $(TABLE_NAME) \
			--attribute-definitions AttributeName=PK,AttributeType=S AttributeName=SK,AttributeType=S \
			--key-schema AttributeName=PK,KeyType=HASH AttributeName=SK,KeyType=RANGE \
			--provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
			--endpoint-url $(DYNAMODB_ENDPOINT) \
			--region us-east-1; \
	fi

.PHONY: stop-dynamodb
stop-dynamodb:
	docker-compose -f $(COMPOSE_FILE) down

.PHONY: init
init-dynamodb: start-dynamodb
	@sleep 3
	$(MAKE) create-table

.PHONY: show-secrets
show-secrets:
	@SOPS_AGE_KEY_FILE=$(HOME)/.config/sops/age/keys.txt sops -d backend/secrets.enc.env
