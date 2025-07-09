module "common" {
  source           = "./common" # Path to your frontend module
  aws_region       = var.aws_region
  project_name     = var.project_name
  root_domain_name = var.root_domain_name
}

module "frontend" {
  source           = "./frontend" # Path to your frontend module
  aws_region       = var.aws_region
  project_name     = var.project_name
  root_domain_name = var.root_domain_name
  hosted_zone_id   = module.common.hosted_zone_id
}

module "backend" {
  source                 = "./backend" # Path to your backend module
  aws_region             = var.aws_region
  project_name           = var.project_name
  aws_account_id         = data.aws_caller_identity.current.account_id
  root_domain_name       = var.root_domain_name
  hosted_zone_id         = module.common.hosted_zone_id
  tapo_ola_calendar_url  = var.tapo_ola_calendar_url
  tapo_ania_calendar_url = var.tapo_ania_calendar_url
  tapo_admin_api_key     = var.tapo_admin_api_key
}

