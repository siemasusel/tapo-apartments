# Makefile at project root

# AWS settings
AWS_PROFILE=tapo-apartamenty
S3_BUCKET=tapo-apartamenty-static-site-021775ea
CLOUDFRONT_DIST_ID=E1BBYT6BYFTRTR

.PHONY: all build sync invalidate deploy terraform terraform-plan run

# Default action
all: deploy

# Build the frontend
build:
	cd frontend && npm run build

# Run local dev server
run:
	cd frontend && npm run dev -- --open

# Sync build to S3
sync:
	aws --profile $(AWS_PROFILE) s3 sync ./frontend/build/ s3://$(S3_BUCKET) --delete

# Invalidate CloudFront cache
invalidate:
	aws cloudfront --profile $(AWS_PROFILE) create-invalidation \
		--distribution-id $(CLOUDFRONT_DIST_ID) \
		--paths "/*"

# Full deployment (build + sync + invalidate)
deploy: build sync invalidate

# Terraform apply
terraform:
	cd terraform && terraform apply

# Terraform plan
terraform-plan:
	cd terraform && terraform plan

