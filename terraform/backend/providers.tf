# Declare the AWS provider for the primary region (from common variable)
provider "aws" {
  region  = var.aws_region     # This var will come from the root terraform/variables.tf
  profile = "tapo-apartamenty" # Your AWS CLI profile
}
