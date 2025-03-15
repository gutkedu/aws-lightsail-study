# The module accepts either an instance name or a container service name
# If instance_name is provided, it will configure networking for an instance
# If container_service_name is provided, it will configure container network settings

# Static IP for instances (only created if instance_name is provided)
resource "aws_lightsail_static_ip" "static_ip" {
  count = var.lightsail_instance_name != null ? 1 : 0
  name  = "${var.project_name}-static-ip"
}

# Attach static IP to instance (only if instance_name is provided)
resource "aws_lightsail_static_ip_attachment" "static_ip_attachment" {
  count          = var.lightsail_instance_name != null ? 1 : 0
  static_ip_name = aws_lightsail_static_ip.static_ip[0].name
  instance_name  = var.lightsail_instance_name
}

# Configure public ports for an instance (only if instance_name is provided)
resource "aws_lightsail_instance_public_ports" "instance_ports" {
  count         = var.lightsail_instance_name != null && length(var.open_ports) > 0 ? 1 : 0
  instance_name = var.lightsail_instance_name

  dynamic "port_info" {
    for_each = var.open_ports
    content {
      protocol  = port_info.value.protocol
      from_port = port_info.value.from_port
      to_port   = port_info.value.to_port
      cidrs     = port_info.value.cidrs
    }
  }
}

# Container service public domain name mapping (only if container_service_name is provided)
# Note: This is a placeholder - Lightsail container services have their own domain management
# that doesn't use static IPs. You would typically use custom domains with container services.
resource "aws_lightsail_container_service_deployment_version" "latest" {
  count        = var.container_service_name != null ? 1 : 0
  service_name = var.container_service_name

  container {
    container_name = "default"      # Replace with your container name
    image          = "nginx:latest" # Replace with your container image
    ports = {
      "80" = "HTTP"
    }
  }

}

