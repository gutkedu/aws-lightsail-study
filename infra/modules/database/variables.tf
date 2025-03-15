variable "db_name" {
  type        = string
  description = "The name of the database"
}

variable "db_master_username" {
  type        = string
  description = "The master username for the database"
}

variable "db_master_password" {
  type        = string
  description = "The master password for the database"
}

variable "db_bundle_id" {
  type        = string
  description = "The bundle ID for the database"
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "Set up our region, that we want to use"
}

variable "project_name" {
  description = "Project's Names"
  type        = string
}
