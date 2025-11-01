terraform {
  backend "gcs" {
    bucket = "applied-pager-476808-j5"
    prefix = "terraform/gcp-mig"
  }
}
