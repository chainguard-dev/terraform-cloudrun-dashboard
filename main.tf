module "registry-prb" {
  source       = "./cloudrun-service"
  project_id   = var.project_id
  service_name = "registry-prober-prb"
  alert_policies = {
    "Prober" : { id = "projects/jason-chainguard/alertPolicies/5448854342283758076" } // TODO input variable
  }
}

output "registry-prb-url" {
  value = module.registry-prb.url
}

module "cron-prb" {
  source     = "./cloudrun-job"
  project_id = var.project_id
  job_name   = "example-cron"
}

output "cron-prb-url" {
  value = module.cron-prb.url
}
