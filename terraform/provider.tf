# Configure the AWS provider
provider "aws" {
  region  = var.aws_region # Specify the desired AWS region
  profile = "tapo-apartamenty"
}

# Specify the required Terraform version
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Use a recent version of the AWS provider
    }
  }
  required_version = ">= 1.0" # Use a recent version of Terraform
}
