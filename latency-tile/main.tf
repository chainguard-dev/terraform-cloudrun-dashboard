variable "title" { type = string }
variable "group_by_fields" { default = [] }
variable "filter" { type = list(string) }

locals {
  bands = [50, 95, 99]
}

output "tile" {
  value = {
    title = var.title
    xyChart = {
      chartOptions = {
        mode = "COLOR"
      }
      dataSets = [for band in local.bands : {
        minAlignmentPeriod = "60s"
        plotType           = "LINE"
        targetAxis         = "Y1"
        legendTemplate     = "${band}th %ile"
        timeSeriesQuery = {
          timeSeriesFilter = {
            aggregation = {
              alignmentPeriod    = "60s"
              perSeriesAligner   = "ALIGN_DELTA"
              crossSeriesReducer = "REDUCE_PERCENTILE_${band}"
              groupByFields      = var.group_by_fields
            }
            filter = join("\n", var.filter)
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
