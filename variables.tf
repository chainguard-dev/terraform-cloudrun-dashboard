variable "project_id" { type = string }

variable "alert_policies" {
  type = map(object({
    id = string
  }))
  default = {}
}
