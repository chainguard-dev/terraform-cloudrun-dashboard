variable "title" { type = string }
variable "alert_name" { type = string }

output "tile" {
  value = {
    title = var.title
    alertChart = {
      name = var.alert_name
    }
  }
}
