resource "aws_lightsail_bucket" "this" {
  name         = var.bucket_name
  bundle_id    = var.bundle_id
  force_delete = true
}

# Resource-based access policy for the Lightsail bucket
resource "aws_lightsail_bucket_resource_access" "instance_access" {
  count         = var.instance_name != null ? 1 : 0
  bucket_name   = aws_lightsail_bucket.this.name
  resource_name = var.instance_name
}
