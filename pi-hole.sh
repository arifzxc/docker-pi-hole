# Masuk sebagai superuser (root) terlebih dahulu, agar mempermudah proses installasi. 

sudo apt install apache2 php php-xmlrpc php-mysql php-gd php-cli php-curl docker.io docker-compose -y

docker-compose up -d

docker run -d -p 9000:9000 --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /opt/portainer:/data portainer/portainer


