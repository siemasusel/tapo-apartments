module "frontend" {
  source             = "./frontend" # Path to your frontend module
  aws_region         = var.aws_region
  project_name       = var.project_name
  custom_domain_name = var.custom_domain_name
}

module "backend" {
  source                 = "./backend" # Path to your backend module
  aws_region             = var.aws_region
  project_name           = var.project_name
  tapo_ola_calendar_url  = var.tapo_ola_calendar_url
  tapo_ania_calendar_url = var.tapo_ania_calendar_url
  tapo_admin_api_key     = var.tapo_admin_api_key
  aws_account_id         = data.aws_caller_identity.current.account_id
}

