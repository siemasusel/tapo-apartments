# Define the AWS region where resources will be created
variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "eu-central-1" # Change to your preferred region
}

# Define a unique name prefix for your resources
variable "project_name" {
  description = "A unique name prefix for the S3 bucket and other resources."
  type        = string
  default     = "tapo-apartamenty" # Change to a unique name
}

variable "custom_domain_name" {
  description = "The custom domain names for the CloudFront distribution (e.g., example.com, www.example.com)"
  type        = list(string)
  default     = []
}

variable "acm_certificate_arn" {
  description = "The ARN of the ACM certificate for the custom domain (e.g., arn:aws:acm:us-east-1:123456789012:certificate/abcdef-123-456)"
  type        = string
  default     = null # Set a default of null if not always used
}
