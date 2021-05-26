#!/bin/sh -x
# Install NGINX Shell Script
export DEBIAN_FRONTEND=noninteractive

echo "Installing NGINX Plus"
echo "Ensure you have nginx-repo.crt & nginx-repo.key in your /tmp directory"
sleep 5
sudo mkdir -p /etc/ssl/nginx
sudo cp /tmp/nginx-repo.crt /etc/ssl/nginx/
sudo cp /tmp/nginx-repo.key /etc/ssl/nginx/
sudo wget https://cs.nginx.com/static/keys/nginx_signing.key && sudo apt-key add nginx_signing.key
sudo wget https://cs.nginx.com/static/keys/app-protect-security-updates.key && sudo apt-key add app-protect-security-updates.key
sudo apt-key add nginx_signing.key
sudo apt-get update
sudo apt-get install apt-transport-https lsb-release ca-certificates -y -qq
printf "deb https://pkgs.nginx.com/plus/ubuntu `lsb_release -cs` nginx-plus\n" | sudo tee /etc/apt/sources.list.d/nginx-plus.list
#printf "deb https://plus-pkgs.nginx.com/ubuntu `lsb_release -cs` nginx-plus\n" | sudo tee /etc/apt/sources.list.d/nginx-plus.list
#sudo wget -q -O /etc/apt/apt.conf.d/90nginx https://cs.nginx.com/static/files/90nginx
printf "deb https://pkgs.nginx.com/app-protect/ubuntu `lsb_release -cs` nginx-plus\n" | sudo tee /etc/apt/sources.list.d/nginx-app-protect.list
printf "deb https://pkgs.nginx.com/app-protect-security-updates/ubuntu `lsb_release -cs` nginx-plus\n" | sudo tee -a /etc/apt/sources.list.d/nginx-app-protect.list
sudo wget -P /etc/apt/apt.conf.d https://cs.nginx.com/static/files/90pkgs-nginx
sudo apt-get update
apt-get install -y nginx-plus
sudo apt-get install app-protect app-protect-attack-signatures
sudo service nginx start
sleep 5
sudo service nginx restart
sleep 5
sudo service nginx status

# vim: syntax=nginx
