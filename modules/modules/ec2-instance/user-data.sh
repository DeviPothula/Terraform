#!/bin/bash

# Detect OS and update/install Nginx
if [ -f /etc/debian_version ]; then
    # For Debian/Ubuntu
    sudo apt update -y
    sudo apt install nginx -y
elif [ -f /etc/redhat-release ]; then
    # For RHEL/Amazon Linux
    sudo yum update -y
    sudo yum install nginx -y
fi

# Start Nginx service
sudo systemctl start nginx
sudo systemctl enable nginx
