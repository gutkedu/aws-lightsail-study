output "container_service_name" {
  description = "Name of the container service"
  value       = aws_lightsail_container_service.this.name
}

output "container_service_url" {
  description = "URL of the container service"
  value       = aws_lightsail_container_service.this.url
}

output "container_service_arn" {
  description = "ARN of the container service"
  value       = aws_lightsail_container_service.this.arn
}

output "container_service_power" {
  description = "Power of the container service"
  value       = aws_lightsail_container_service.this.power
}

output "container_service_scale" {
  description = "Scale of the container service"
  value       = aws_lightsail_container_service.this.scale
}

output "container_service_public_domain_names" {
  description = "Public domain names of the container service"
  value       = aws_lightsail_container_service.this.public_domain_names
}

output "deployment_version" {
  description = "Version of the container service deployment"
  value       = aws_lightsail_container_service_deployment_version.this.version
}
