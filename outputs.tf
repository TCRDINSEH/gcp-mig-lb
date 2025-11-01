output "project_id" {
  description = "Project ID in use"
  value       = var.project_id
}

output "region" {
  description = "Region in use"
  value       = var.region
}

output "zone" {
  description = "Zone in use"
  value       = var.zone
}

output "network_self_link" {
  description = "VPC network self_link if available"
  value       = module.network.network_self_link
}

output "subnetwork_self_link" {
  description = "Subnetwork self_link if available"
  value       = module.network.subnetwork_self_link
}

output "proxy_subnetwork_self_link" {
  description = "Proxy-only subnetwork self_link if available"
  value       = module.network.proxy_subnetwork_self_link
}

output "instance_template_self_link" {
  description = "Instance template self_link if available"
  value       = module.compute_mig.instance_template_self_link
}

output "instance_group_self_link" {
  description = "Managed instance group self_link if available"
  value       = module.compute_mig.instance_group_self_link
}

# output "backend_service_self_link" {
#   description = "Backend service self_link if available"
#   value       = module.load_balancer.backend_service_self_link
# }

# output "lb_ip_address" {
#   description = "Load balancer public IP (global reserved address or forwarding rule) if available"
#   value       = module.load_balancer.lb_ip_address
# }