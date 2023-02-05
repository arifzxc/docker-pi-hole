#!/bin/bash
# Masuk sebagai superuser (root) terlebih dahulu, agar mempermudah proses installasi. 

wget https://download.docker.com/linux/debian/gpg
apt-key add gpg
cd /etc/apt/sources.list.d/
touch /etc/apt/sources.list.d/docker.list
echo "deb [arch=arm64] https://download.docker.com/linux/debian bullseye stable" > docker.list
cd 
sudo apt update -y

sudo apt install apache2 php php-xmlrpc php-mysql php-gd php-cli php-curl docker.io docker-compose -y

docker pull portainer/portainer
mkdir /opt/portainer /data

docker-compose up -d

docker run -d -p 9000:9000 --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /opt/portainer:/data portainer/portainer


