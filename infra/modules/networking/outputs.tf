output "static_ip_address" {
  description = "The static IP address (only for instance-based deployments)"
  value       = var.lightsail_instance_name != null ? (length(aws_lightsail_static_ip.static_ip) > 0 ? aws_lightsail_static_ip.static_ip[0].ip_address : null) : null
}

output "container_url" {
  description = "The container service URL (only for container-based deployments)"
  value       = var.container_service_name != null ? (length(aws_lightsail_container_service_deployment_version.latest) > 0 ? "Container service deployed - URL available through container service module" : null) : null
}

output "deployment_type" {
  description = "The type of deployment configured"
  value       = var.lightsail_instance_name != null ? "instance" : (var.container_service_name != null ? "container" : "none")
}
