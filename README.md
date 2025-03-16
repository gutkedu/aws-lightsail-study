# aws-lightsail-study

Project to study and experiment with AWS Lightsail infrastructure using Terraform.

## Architecture Overview

The infrastructure consists of several modular components that work together to create a complete application environment on AWS Lightsail.

## Modules

### 1. Instance Module
- Provisions Ubuntu 22.04 instances with configurable sizes
- Supports custom user data for instance initialization
- Includes Docker installation and configuration
- Provisions additional disk storage when needed

### 2. Networking Module
- Manages Lightsail instance networking components
- Configures public ports (firewall rules)
- Handles static IP allocation and attachment
- Supports container service networking when needed
- TODO: Add support for VPC and subnets
- TODO: Add support for custom DNS configuration
- TODO: Add support for SSL certificate management
- TODO: Add support for load balancer configuration

### 3. Database Module
- Provisions PostgreSQL database instances
- Configures database credentials and parameters
- Exposes connection endpoints for applications

### 4. Storage Module
- Manages object storage resources
- Provides S3-compatible storage buckets
- Configures access policies and endpoints

### 5. Container Module
- Provisions container services on Lightsail instances
- Supports Docker and container orchestration tools
- Configures networking and security for container workloads

## Getting Started

### Prerequisites
- AWS account with Lightsail access
- Terraform v0.14+ installed
- AWS CLI configured with appropriate credentials

### Deployment

```
# Initialize Terraform
terraform init

# Plan the deployment
terraform plan

# Apply the configuration
terraform apply

# Destroy the resources
terraform destroy
```

## Configuration

The project supports customization through variables defined in `.tfvars` files:
```
# Example dev.tfvars
aws_region  = "us-west-2"
aws_profile = "default"
project_name = "lightsail-demo"
instance_blueprint = "ubuntu_22_04"
instance_bundle = "micro_3_0"
```

## Deployed Resources

- **Web Server**: Ubuntu 22.04 instance running Node.js Express
- **Database**: PostgreSQL database for application data
- **Docker**: Installed and configured for container workloads
- **Network Security**: Configured firewall rules for SSH and web traffic