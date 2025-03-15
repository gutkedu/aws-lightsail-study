resource "aws_lightsail_container_service" "this" {
  name        = "${lower(replace(var.project_name, "_", "-"))}-container-${var.container_name}"
  power       = var.power
  scale       = var.scale
  is_disabled = false

  # Public domain names for the container service
  dynamic "private_registry_access" {
    for_each = var.private_registry != null ? [1] : []
    content {
      dynamic "ecr_image_puller_role" {
        for_each = try(var.private_registry.ecr_image_puller_role, null) != null ? [1] : []
        content {
          is_active = var.private_registry.ecr_image_puller_role.is_active
        }
      }
    }
  }

  tags = var.tags
}

# Deploy container to the service
resource "aws_lightsail_container_service_deployment_version" "this" {
  service_name = aws_lightsail_container_service.this.name

  # Container configuration
  dynamic "container" {
    for_each = var.containers != null ? var.containers : {
      (var.container_name) = {
        image       = var.container_image
        command     = var.command
        environment = var.environment
        ports       = var.ports
      }
    }

    content {
      container_name = container.key
      image          = container.value.image
      command        = try(container.value.command, null)

      # Environment variables as a map
      environment = try(container.value.environment, {})

      # Ports as a map with string keys and values
      ports = {
        for port in try(container.value.ports, []) :
        tostring(port.port) => port.protocol
      }
    }
  }

  # Public endpoint configuration
  dynamic "public_endpoint" {
    for_each = var.public_endpoint != null ? [var.public_endpoint] : []
    content {
      container_name = public_endpoint.value.container_name
      container_port = public_endpoint.value.container_port

      health_check {
        healthy_threshold   = public_endpoint.value.health_check.healthy_threshold
        unhealthy_threshold = public_endpoint.value.health_check.unhealthy_threshold
        timeout_seconds     = public_endpoint.value.health_check.timeout_seconds
        interval_seconds    = public_endpoint.value.health_check.interval_seconds
        path                = public_endpoint.value.health_check.path
        success_codes       = public_endpoint.value.health_check.success_codes
      }
    }
  }
}
