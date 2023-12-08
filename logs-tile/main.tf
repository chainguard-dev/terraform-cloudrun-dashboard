variable "title" { type = string }
variable "filter" { type = list(string) }

output "tile" {
  value = {
    title = var.title
    logsPanel = {
      filter = join("\n", var.filter)
    }
    resourceNames = []
  }
}
