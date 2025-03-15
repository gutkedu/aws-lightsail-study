variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "lightsail_instance_name" {
  description = "Name of the Lightsail instance (if using instance-based deployment)"
  type        = string
  default     = null
}

variable "container_service_name" {
  description = "Name of the Lightsail container service (if using container-based deployment)"
  type        = string
  default     = null
}

variable "open_ports" {
  description = "List of ports to open on the instance (only applies to instance-based deployment)"
  type = list(object({
    protocol  = string # tcp, udp, or all
    from_port = number
    to_port   = number
    cidrs     = list(string) # List of CIDR blocks
  }))
  default = []
}

variable "aws_region" {
  description = "AWS region for the resources"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone suffix (a, b, c, etc.)"
  type        = string
  default     = "a"
}
