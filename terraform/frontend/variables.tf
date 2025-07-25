variable "aws_region" {
  description = "The AWS region for frontend resources."
  type        = string
}

variable "project_name" {
  description = "Project name for frontend resources."
  type        = string
}

variable "root_domain_name" {
  description = "The primary root domain name (e.g., tapoapartamenty.pl)."
  type        = string
}

variable "hosted_zone_id" {
  description = "The ID of the Route 53 Hosted Zone where DNS records for the domain will be managed."
  type        = string
}
