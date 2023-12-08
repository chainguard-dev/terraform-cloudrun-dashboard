variable "project_id" { type = string }
variable "service_name" { type = string }

variable "prober_alert_policies" {
  type = map(object({
    id = string
  }))
  default = {}
}
