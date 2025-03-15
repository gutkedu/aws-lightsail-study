variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "service_name" {
  description = "Name of the container service"
  type        = string
}

variable "aws_region" {
  description = "AWS region for the container service"
  type        = string
}

variable "power" {
  description = "The power specification for the container service (nano, micro, small, medium, large, xlarge)"
  type        = string
  default     = "micro"
}

variable "scale" {
  description = "The scale specification for the container service (number of nodes)"
  type        = number
  default     = 1
}

# Container definition variables
variable "container_name" {
  description = "Name of the default container"
  type        = string
  default     = "app"
}

variable "container_image" {
  description = "Docker image for the default container"
  type        = string
}

variable "command" {
  description = "Command to run in the container"
  type        = list(string)
  default     = null
}

variable "environment" {
  description = "Environment variables for the default container"
  type        = map(string)
  default     = {}
}

variable "ports" {
  description = "Ports to open on the container"
  type = list(object({
    port     = number
    protocol = string
  }))
  default = []
}

# Multiple containers configuration
variable "containers" {
  description = "Map of container definitions"
  type = map(object({
    image       = string
    command     = list(string)
    environment = map(string)
    ports = list(object({
      port     = number
      protocol = string
    }))
  }))
  default = null
}

# Public endpoint configuration
variable "public_endpoint" {
  description = "Public endpoint configuration"
  type = object({
    container_name = string
    container_port = number
    health_check = object({
      path                = string
      success_codes       = string
      healthy_threshold   = number
      unhealthy_threshold = number
      timeout_seconds     = number
      interval_seconds    = number
    })
  })
  default = null
}

# Private registry access
variable "private_registry" {
  description = "Private registry access configuration"
  type = object({
    ecr_image_puller_role = object({
      is_active = bool
    })
  })
  default = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
