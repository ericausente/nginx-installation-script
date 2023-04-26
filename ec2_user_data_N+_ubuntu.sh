#!/bin/bash

# Create /etc/ssl/nginx directory and switch to it
sudo mkdir /etc/ssl/nginx
cd /etc/ssl/nginx

# Create nginx-repo.crt file
sudo tee nginx-repo.crt > /dev/null << EOT
-----BEGIN CERTIFICATE-----
-----END CERTIFICATE-----
EOT

# Create nginx-repo.key file
sudo tee nginx-repo.key > /dev/null << EOT
-----BEGIN PRIVATE KEY-----
-----END PRIVATE KEY-----
EOT

# Install prerequisite packages
sudo apt-get update
sudo apt-get install -y apt-transport-https lsb-release ca-certificates wget gnupg2 ubuntu-keyring

# Download and add NGINX signing key and App Protect security updates signing key
wget -qO - https://cs.nginx.com/static/keys/nginx_signing.key | gpg --dearmor | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
wget -qO - https://cs.nginx.com/static/keys/app-protect-security-updates.key | gpg --dearmor | sudo tee /usr/share/keyrings/app-protect-security-updates.gpg >/dev/null

# Add the NGINX Plus repository
printf "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] https://pkgs.nginx.com/plus/ubuntu $(lsb_release -cs) nginx-plus\n" | sudo tee /etc/apt/sources.list.d/nginx-plus.list

# Download the nginx-plus apt configuration to /etc/apt/apt.conf.d
sudo wget -P /etc/apt/apt.conf.d https://cs.nginx.com/static/files/90pkgs-nginx

# Update the repository information
sudo apt-get update

# Install the nginx-plus package. Any older NGINX Plus package is automatically replaced.
sudo apt-get install -y nginx-plus

# Check the nginx binary version to ensure that you have NGINX Plus installed correctly
nginx -v
