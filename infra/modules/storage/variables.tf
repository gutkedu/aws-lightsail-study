variable "bucket_name" {
  description = "Name of the Lightsail bucket"
  type        = string
}

variable "bundle_id" {
  description = "Bundle ID for the Lightsail bucket"
  type        = string
  default     = "small_1_0"
}

variable "instance_name" {
  description = "Name of the Lightsail instance to grant access to the bucket"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
