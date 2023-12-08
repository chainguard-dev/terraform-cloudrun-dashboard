variable "title" { type = string }
variable "group_by_fields" { default = [] }
variable "filter" { type = list(string) }
variable "plot_type" { default = "LINE" }
variable "primary_align" { default = "ALIGN_RATE" }
variable "primary_reduce" { default = "REDUCE_NONE" }
variable "secondary_align" { default = "ALIGN_NONE" }
variable "secondary_reduce" { default = "REDUCE_NONE" }

output "tile" {
  value = {
    title = var.title
    xyChart = {
      chartOptions = {
        mode = "COLOR"
      }
      dataSets = [{
        minAlignmentPeriod = "60s"
        plotType           = var.plot_type
        targetAxis         = "Y1"
        timeSeriesQuery = {
          timeSeriesFilter = {
            aggregation = {
              alignmentPeriod    = "60s"
              perSeriesAligner   = var.primary_align
              crossSeriesReducer = var.primary_reduce
              groupByFields      = var.group_by_fields
            }
            filter = join("\n", var.filter)
            secondaryAggregation = {
              alignmentPeriod    = "60s"
              perSeriesAligner   = var.secondary_align
              crossSeriesReducer = var.secondary_reduce
              groupByFields      = var.group_by_fields
            }
          }
        }
      }]
      timeshiftDuration = "0s"
      yAxis = {
        label = "y1Axis"
        scale = "LINEAR"
      }
    }
  }
}
