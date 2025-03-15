variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "instance_name" {
  description = "Name of the instance (will be combined with project_name)"
  type        = string
}

variable "aws_region" {
  description = "AWS region for the Lightsail instance"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone suffix (a, b, c, etc.)"
  type        = string
  default     = "a"
}

variable "blueprint_id" {
  description = "The ID for a virtual private server image"
  type        = string
}

variable "bundle_id" {
  description = "The bundle of specification for the instance"
  type        = string
  default     = "nano_2_0"
}

variable "user_data" {
  description = "Launch script to configure server with additional capabilities"
  type        = string
  default     = null
}

variable "key_pair_name" {
  description = "The key pair name to use for SSH access"
  type        = string
  default     = null
}

variable "additional_disk_size_gb" {
  description = "Size of additional storage disk in GB (0 for no disk)"
  type        = number
  default     = 0
}

variable "disk_path" {
  description = "The disk path to expose to the instance"
  type        = string
  default     = "/dev/xvdf"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
