output "database_endpoint" {
  description = "The database endpoint to use for connections"
  value       = aws_lightsail_database.postgres_db.master_endpoint_address
}

output "database_name" {
  description = "The name of the created database"
  value       = aws_lightsail_database.postgres_db.relational_database_name
}

