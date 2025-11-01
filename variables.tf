variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone (for zonal resources)"
  type        = string
  default     = "us-central1-c"
}

variable "network_name" {
  description = "VPC network name or self_link"
  type        = string
  default     = "apache-mig-network"
}

variable "subnetwork_name" {
  description = "Subnetwork name or self_link"
  type        = string
  default     = "apache-mig-subnetwork"
}

variable "proxy_subnetwork_name" {
  description = "Proxy-only subnetwork name or self_link (for EXTERNAL_MANAGED proxies)"
  type        = string
  default     = "apache-mig-proxy-subnet"
}

variable "ssh_source_ip_range" {
  description = "List of CIDR ranges allowed to SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "target_size" {
  description = "Default target size for managed instance groups"
  type        = number
  default     = 2
}

variable "instance_machine_type" {
  description = "Machine type for instances"
  type        = string
  default     = "e2-micro"
}

variable "image_family" {
  description = "Image family to use for boot disk"
  type        = string
  default     = "debian-11"
}

variable "image_project" {
  description = "Project that contains the image family"
  type        = string
  default     = "debian-cloud"
}

variable "credentials_file" {
  description = "Optional path to service account JSON (leave empty to use ADC)"
  type        = string
  default     = ""
}

variable "name" {
  description = "Base name for resources"
  type        = string
  default     = "apache"
}