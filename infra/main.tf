# Deploy a Node.js Container on Lightsail
module "nodejs_container" {
  source = "./modules/container"

  project_name = var.project_name
  service_name = "nodejs-app"
  aws_region   = var.aws_region

  # Container configuration
  container_name = "nodejs-app"
  # Change the container image to one that has a web server running
  container_image = "node:18-alpine"
  # Add a command to start a simple web server
  command = ["node", "-e", "const http = require('http'); const server = http.createServer((req, res) => { res.writeHead(200); res.end('Hello from Node.js!'); }); server.listen(3000, () => console.log('Server running on port 3000'));"]

  # You can specify ports to open
  ports = [
    {
      port     = 3000
      protocol = "HTTP" # Lightsail will create a load balancer for HTTP
    }
  ]

  # Environment variables for the container
  environment = {
    "NODE_ENV" = "production"
  }

  public_endpoint = {
    container_name = "nodejs-app"
    container_port = 3000
    health_check = {
      path                = "/"
      success_codes       = "200-299"
      healthy_threshold   = 2
      unhealthy_threshold = 2
      timeout_seconds     = 5
      interval_seconds    = 30
    }
  }

  # Resource scaling
  scale = 1       # Number of container nodes
  power = "micro" # nano, micro, small, medium, large, xlarge

  tags = {
    Name    = "NodeJS Application Container"
    Project = var.project_name
    Role    = "Application"
  }
}

# Add an Amazon Linux instance
module "linux_instance" {
  source = "./modules/instance"

  project_name  = var.project_name
  instance_name = "linux-server"
  blueprint_id  = "ubuntu_22_04" # Ubuntu 22.04 LTS
  bundle_id     = "micro_3_0"    # 2 vCPUs, 1 GB RAM
  aws_region    = var.aws_region

  user_data = <<-EOT
#!/bin/bash
set -e  # Exit on any error

# Install Docker (keeping this part as requested)
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo systemctl start docker
sudo systemctl enable docker
echo "Docker installed successfully"

# Install Node.js and npm
echo "Installing Node.js and npm..."
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo bash -
sudo apt-get install -y nodejs
npm --version && node --version

# Create Express application directory
mkdir -p /home/ubuntu/express-app
cd /home/ubuntu/express-app

# Initialize npm and install Express
npm init -y
npm install express

# Create Express application
cat > app.js << 'EOF'
const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Hello World from Express running directly on AWS Lightsail!');
});

app.listen(port, () => {
  console.log(`Express server running`);
});
EOF

# Set proper ownership
sudo chown -R ubuntu:ubuntu /home/ubuntu/express-app

# Create systemd service file to auto-start Express
sudo cat > /etc/systemd/system/express-app.service << 'EOF'
[Unit]
Description=Express Hello World App
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/home/ubuntu/express-app
ExecStart=/usr/bin/node app.js
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# Enable and start the service
sudo systemctl daemon-reload
sudo systemctl enable express-app.service
sudo systemctl start express-app.service
echo "Express application deployed and running on port 3000"
EOT

  tags = {
    Name    = "Linux Server"
    Project = var.project_name
    Role    = "Web Server"
  }
}

# Update networking module to use the Linux instance
module "instance_networking" {
  source = "./modules/networking"

  project_name = var.project_name
  aws_region   = var.aws_region

  container_service_name  = null
  lightsail_instance_name = module.linux_instance.instance_name

  # Open ports for SSH, HTTP, and Express
  open_ports = [
    {
      protocol  = "tcp"
      from_port = 22
      to_port   = 22
      cidrs     = ["0.0.0.0/0"]
    },
    {
      protocol  = "tcp"
      from_port = 80
      to_port   = 80
      cidrs     = ["0.0.0.0/0"]
    },
    {
      protocol  = "tcp"
      from_port = 3000
      to_port   = 3000
      cidrs     = ["0.0.0.0/0"]
    }
  ]
}

module "networking" {
  source = "./modules/networking"

  project_name = var.project_name
  aws_region   = var.aws_region

  container_service_name  = module.nodejs_container.container_service_name
  lightsail_instance_name = null
}


module "postgres_database" {
  source = "./modules/database"

  aws_region         = var.aws_region
  project_name       = var.project_name
  db_name            = var.db_name
  db_master_username = var.db_master_username
  db_master_password = var.db_master_password
  db_bundle_id       = var.db_bundle_id
}

module "storage" {
  source      = "./modules/storage"
  bucket_name = "bucket-${lower(replace(var.project_name, "_", "-"))}-${var.aws_region}"
  bundle_id   = "small_1_0"

  instance_name = module.linux_instance.instance_name

  tags = {
    Name    = "GIF Storage"
    Project = var.project_name
  }
}
