## Creates an AWS Lightsail Instance.
resource "aws_lightsail_instance" "this" {
  name              = "${lower(replace(var.project_name, "_", "-"))}-${var.instance_name}" ## Name of lightsail instance in AWS
  availability_zone = "${var.aws_region}${var.availability_zone}"                          ## AZ
  blueprint_id      = var.blueprint_id                                                     ## Blueprint ID (OS/Application)
  bundle_id         = var.bundle_id                                                        ## Instance size

  user_data = var.user_data ## Launch script to configure server with additional capabilitiess

  tags = merge(
    {
      Name = "${var.project_name}-${var.instance_name}"
    },
    var.tags
  )

  # Optional key pair name
  key_pair_name = var.key_pair_name
}

# Add a disk to the instance if specified
resource "aws_lightsail_disk" "this" {
  count             = var.additional_disk_size_gb > 0 ? 1 : 0
  name              = "${var.project_name}-${var.instance_name}-disk"
  availability_zone = "${var.aws_region}${var.availability_zone}"
  size_in_gb        = var.additional_disk_size_gb
  tags              = var.tags
}

resource "aws_lightsail_disk_attachment" "this" {
  count         = var.additional_disk_size_gb > 0 ? 1 : 0
  disk_name     = aws_lightsail_disk.this[0].name
  instance_name = aws_lightsail_instance.this.name
  disk_path     = var.disk_path
}
