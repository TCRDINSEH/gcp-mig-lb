output "instance_template_self_link" {
  description = "Instance template self_link"
  value       = google_compute_instance_template.default.self_link
}

output "instance_group_self_link" {
  description = "Managed instance group self_link"
  value       = google_compute_instance_group_manager.default.instance_group
}