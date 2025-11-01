variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "instance_group_self_link" {
  description = "Self-link of the instance group to balance traffic to"
  type        = string
}
