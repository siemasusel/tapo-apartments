# Declare the AWS provider for the primary region (from common variable)
provider "aws" {
  region  = var.aws_region     # This var will come from the root terraform/variables.tf
  profile = "tapo-apartamenty" # Your AWS CLI profile
}

# Declare the AWS provider for us-east-1 (required for CloudFront/ACM)
provider "aws" {
  alias   = "us_east_1"
  region  = "us-east-1"
  profile = "tapo-apartamenty" # Your AWS CLI profile
}
