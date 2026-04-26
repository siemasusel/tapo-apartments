variable "aws_region" {
  description = "AWS region for the Terraform state bucket and lock table."
  type        = string
  default     = "eu-central-1"
}

variable "aws_profile" {
  description = "AWS CLI profile used for bootstrapping remote state."
  type        = string
  default     = "tapo-apartamenty"
}

variable "project_name" {
  description = "Project prefix used in Terraform state resource names."
  type        = string
  default     = "tapo-apartamenty"
}

variable "state_key" {
  description = "Suggested object key for the root Terraform state file."
  type        = string
  default     = "root/terraform.tfstate"
}
