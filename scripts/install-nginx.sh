!/bin/bash
# Update packages
sudo apt-get update -y
# Install Nginx
sudo apt-get install nginx -y
sudo echo "Hello, I am going to create an auto-scaling project uing nginx" > /var/www/html/index.html
# Enable and start Nginx
sudo systemctl enable nginx
sudo systemctl start nginx
