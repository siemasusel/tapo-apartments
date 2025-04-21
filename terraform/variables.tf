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

# Optional: Define a custom domain name
variable "custom_domain_name" {
  description = "Optional: Your custom domain name (e.g., www.example.com). If provided, you'll need an ACM certificate."
  type        = string
  default     = null # Set to your domain if you have one and a corresponding ACM certificate
}

# Optional: Define the ARN of the ACM certificate for the custom domain
variable "acm_certificate_arn" {
  description = "Optional: The ARN of the ACM certificate for the custom domain name. Required if custom_domain_name is set."
  type        = string
  default     = null # Set to your certificate ARN if using a custom domain
}
