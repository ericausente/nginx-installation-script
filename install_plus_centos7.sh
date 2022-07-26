#!/bin/bash

echo "Installing NGINX Plus"
echo "Ensure you have nginx-repo.crt & nginx-repo.key in your /tmp directory"
sleep 5
sudo mkdir -p /etc/ssl/nginx
sudo cp /tmp/nginx-repo.crt /etc/ssl/nginx/
sudo cp /tmp/nginx-repo.key /etc/ssl/nginx/
sudo yum install -y ca-certificates wget epel-release
sudo wget -P /etc/yum.repos.d https://cs.nginx.com/static/files/nginx-plus-7.4.repo
sudo wget -P /etc/yum.repos.d https://cs.nginx.com/static/files/app-protect-7.repo
sudo yum install -y nginx-plus app-protect app-protect-attack-signatures
sudo systemctl enable nginx.service
sudo service nginx start
sleep 5
sudo service nginx restart
sleep 5
sudo service nginx status

