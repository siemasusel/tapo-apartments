variable "aws_region" {
  description = "The AWS region for frontend resources."
  type        = string
}

variable "project_name" {
  description = "Project name for frontend resources."
  type        = string
}

variable "custom_domain_name" {
  description = "The custom domain names for the CloudFront distribution (e.g., example.com, www.example.com)"
  type        = list(string)
  default     = []
}
