output "instance_name" {
  description = "Name of the Lightsail instance"
  value       = aws_lightsail_instance.this.name
}

output "instance_id" {
  description = "ID of the Lightsail instance"
  value       = aws_lightsail_instance.this.id
}

output "instance_arn" {
  description = "ARN of the Lightsail instance"
  value       = aws_lightsail_instance.this.arn
}

output "instance_ip" {
  description = "Public IP address of the Lightsail instance"
  value       = aws_lightsail_instance.this.public_ip_address
}

output "instance_username" {
  description = "Username to connect to the instance via SSH"
  value       = aws_lightsail_instance.this.username
}

output "disk_name" {
  description = "Name of the additional disk"
  value       = var.additional_disk_size_gb > 0 ? aws_lightsail_disk.this[0].name : null
}
