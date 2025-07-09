# Define the AWS region where resources will be created
variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "eu-central-1"
}

data "aws_caller_identity" "current" {}

# Define a unique name prefix for your resources
variable "project_name" {
  description = "A unique name prefix for the S3 bucket and other resources."
  type        = string
  default     = "tapo-apartamenty"
}

variable "root_domain_name" {
  description = "The primary root domain name (e.g., tapoapartamenty.pl)."
  type        = string
}

variable "tapo_ola_calendar_url" {
  type      = string
  sensitive = true
}

variable "tapo_ania_calendar_url" {
  type      = string
  sensitive = true
}

variable "tapo_admin_api_key" {
  type      = string
  sensitive = true
}

