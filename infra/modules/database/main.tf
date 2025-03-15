## Creates a PostgreSQL database in Lightsail
resource "aws_lightsail_database" "postgres_db" {
  relational_database_name = var.db_name
  availability_zone        = "${var.aws_region}a"
  master_database_name     = "postgres"
  master_username          = var.db_master_username
  master_password          = var.db_master_password
  blueprint_id             = "postgres_16" # Updated to match documentation
  bundle_id                = var.db_bundle_id

  preferred_backup_window      = "03:00-04:00"
  preferred_maintenance_window = "sun:05:00-sun:06:00"
  publicly_accessible          = false
  backup_retention_enabled     = true

  skip_final_snapshot = true ## Skip the final snapshot when deleting the database

  tags = {
    Name = "${var.project_name}-postgres-db"
  }
}
