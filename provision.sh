#!/bin/bash

# Update system packages
sudo apt update -y

# Install Docker if it does not exist
if ! command -v docker &> /dev/null
then
  echo "Installing Docker..."
  sudo apt install docker.io -y
  sudo systemctl start docker
  sudo systemctl enable docker
fi

# Install Docker Compose if missing
if ! command -v docker-compose &> /dev/null
then
  echo "Installing Docker Compose..."
  sudo apt install docker-compose -y
fi

# Install AWS CLI
if ! command -v aws &> /dev/null
then
  echo "Installing AWS CLI..."
  sudo apt install awscli -y
fi

# Create MySQL storage directory
sudo mkdir -p /mnt/mysql-data

# Allow Docker to write there
sudo chmod 777 /mnt/mysql-data

echo "Provisioning complete"
