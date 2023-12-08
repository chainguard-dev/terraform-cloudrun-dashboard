# `terraform-cloudrun-dashboard`

This module creates `google_monitoring_dashboard` resources in a repeatable structured way.

It takes a project ID and Cloud Run service name as an input, and creates a dashboard with the following tiles:

- Request count grouped by response status
- Incoming request latency (p50,p95,p99)
- Instance count grouped by revision name
- CPU utilization
- Memory utilization
- Startup latency
- Bytes sent
- Bytes received

## Usage

```hcl
module "cloudrun-dashboard" {
  source = "https://github.com/chainguard-dev/terraform-cloudrun-dashboard/"
  project_id = "[MY-PROJECT]"
  service_name = "[MY-SERVICE]"
}
```

When exporting a dashboard from the console, there are certain fields that the console defaults to that do not get reconciled by the tf provider.
This results in permanent diffs during `terraform plan`.
In most cases you shouldn't have to care, except when redefining exported dashboards.

## Advanced Usage: Customizing a dashboard

Tiles in the dashboard are defined as sub-modules in this repository.

This means that, in addition to just using the module directly, you can define your own module using the sub-modules as a base.

Based on [`main.tf`](./main.tf), you can create a new `google_monitoring_dashboard` resource like so:

```hcl
module "fancy" {
  source = "https://github.com/chainguard-dev/terraform-cloudrun-dashboard//tile"
  title = "Fancy Tile"
  filter = [
    "metric.type=\"run.googleapis.com/request_count\"", // Show request counts...
    "resource.type=\"cloud_run_revision\""              // ...for all Cloud Run services
  ]
  group_by_fields = ["resource.label.\"service_name\""] // ...grouped by service name
}

resource "google_monitoring_dashboard" "dashboard" {
  project = var.project_id

  dashboard_json = jsonencode({
    "displayName" : "${var.service_name} Custom Dashboard",
    "gridLayout" : {
      "columns" : 3,
      "widgets" : [
        module.fancy.tile,
        //... add more here
      ]
    }
  })
}
```
