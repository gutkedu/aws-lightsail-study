variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "Set up our region, that we want to use"
}

variable "aws_profile" {
  type        = string
  default     = "default"
  description = "Set up our profile, that we want to use"
}

variable "project_name" {
  description = "Project's Names"
  type        = string
}

variable "bundle_id" {
  type        = string
  default     = "nano_2_0"
  description = "Options for instance size"
}

# Database variables
variable "db_name" {
  description = "Name of the PostgreSQL database"
  type        = string
}

variable "db_master_username" {
  description = "Master username for the database"
  type        = string
}

variable "db_master_password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true
}

variable "db_bundle_id" {
  description = "Bundle ID for the Lightsail database instance"
  type        = string
}
