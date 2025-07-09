# Declare the AWS provider for the primary region of your frontend resources.
# This variable (aws_region) comes from the root terraform/variables.tf.
provider "aws" {
  region  = var.aws_region
  profile = "tapo-apartamenty" # Your AWS CLI profile
}

# Declare the AWS provider for us-east-1, specifically required for CloudFront and ACM.
# These services are global and their certificates MUST be provisioned in us-east-1.
provider "aws" {
  alias   = "us_east_1"
  region  = "us-east-1"
  profile = "tapo-apartamenty" # Your AWS CLI profile
}

