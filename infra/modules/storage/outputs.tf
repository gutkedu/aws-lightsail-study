output "bucket_name" {
  description = "The name of the bucket"
  value       = aws_lightsail_bucket.this.name
}

output "bucket_arn" {
  description = "The ARN of the bucket"
  value       = aws_lightsail_bucket.this.arn
}

output "bucket_url" {
  description = "The URL of the bucket"
  value       = aws_lightsail_bucket.this.url
}
