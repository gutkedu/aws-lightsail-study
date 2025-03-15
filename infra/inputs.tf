variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "Set up our region, that we want to use"
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
variable "lightsail_blueprints" {
  type        = map(string)
  description = "The ID for a virtual private server image. A list of available blueprint AWS CLI command: aws lightsail get-blueprints"
}
