variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "zone" {
  description = "GCP zone"
  type        = string
}

variable "target_size" {
  description = "Default target size for managed instance groups"
  type        = number
}

variable "network_name" {
  description = "VPC network name"
  type        = string
}

variable "instance_machine_type" {
  description = "Machine type for instances"
  type        = string
}

variable "image_family" {
  description = "Image family to use for boot disk"
  type        = string
}

variable "image_project" {
  description = "Project that contains the image family"
  type        = string
}

variable "subnetwork_self_link" {
  description = "Self-link of the subnetwork"
  type        = string
}

variable "tags" {
  description = "List of network tags to apply to instances"
  type        = list(string)
  default     = []
}

variable "name" {
  description = "Base name for resources"
  type        = string
}

# Autoscaling settings
variable "min_replicas" {
  description = "Minimum number of instances"
  type        = number
  default     = 2
}

variable "max_replicas" {
  description = "Maximum number of instances"
  type        = number
  default     = 10
}

variable "cpu_target" {
  description = "Target CPU utilization to trigger scaling (e.g., 0.6 for 60%)"
  type        = number
  default     = 0.6
}
