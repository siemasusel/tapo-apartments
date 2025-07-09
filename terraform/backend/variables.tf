variable "aws_region" {
  description = "The AWS region for backend resources."
  type        = string
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "project_name" {
  description = "Project name for backend resources."
  type        = string
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  type        = string
  default     = "ApartmentsData"
}

variable "root_domain_name" {
  description = "The primary root domain name (e.g., tapoapartamenty.pl)."
  type        = string
}

variable "hosted_zone_id" {
  description = "The ID of the Route 53 Hosted Zone where DNS records for the domain will be managed."
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

