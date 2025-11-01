output "network_self_link" {
  description = "VPC network self_link"
  value       = google_compute_network.vpc_network.self_link
}

output "network_name" {
  description = "VPC network name"
  value       = google_compute_network.vpc_network.name
}

output "subnetwork_self_link" {
  description = "Subnetwork self_link"
  value       = google_compute_subnetwork.vpc_subnetwork.self_link
}

output "proxy_subnetwork_self_link" {
  description = "Proxy-only subnetwork self_link"
  value       = google_compute_subnetwork.proxy_only_subnetwork.self_link
}