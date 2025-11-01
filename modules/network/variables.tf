variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "network_name" {
  description = "VPC network name"
  type        = string
}

variable "subnetwork_name" {
  description = "Subnetwork name"
  type        = string
}

variable "proxy_subnetwork_name" {
  description = "Proxy-only subnetwork name"
  type        = string
}

variable "ssh_source_ip_range" {
  description = "List of CIDR ranges allowed to SSH"
  type        = list(string)
}

variable "health_check_target_tag" {
  description = "Network tag for instances to allow health checks"
  type        = string
}

variable "ssh_target_tag" {
  description = "Network tag for instances to allow SSH"
  type        = string
}