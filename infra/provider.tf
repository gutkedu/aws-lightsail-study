provider "aws" {
  region  = var.aws_region
  profile = "gutkedu-terraform"
  default_tags {
    tags = {
      Project = "wordpress-ligthsail"
    }
  }
}
