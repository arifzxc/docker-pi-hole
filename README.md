# Install pi-hole in a docker

- <b>Docker</b> adalah seperangkat platform sebagai produk layanan yang menggunakan virtualisasi tingkat OS untuk mengirimkan perangkat lunak dalam paket yang disebut kontainer.

- <b>Pi-hole</b> adalah iklan tingkat jaringan Linux dan aplikasi pemblokiran pelacak Internet yang bertindak sebagai lubang pembuangan DNS dan opsional server DHCP, dimaksudkan untuk digunakan pada jaringan pribadi.

# SAYA MEMPUNYAI 2 PILIHAN PROSES INSTALLASI

<b><h2> 1. Installasi dengan shell script (.sh) installasi jadi lebih mudah dan auto selesai dengan sendirinya. </b></h2>

<b>Disarankan masuk sebagai superuser (root) terlebih dahulu, agar mempermudah ketika proses penginstalan.

Dengan perintah : </b>
```
sudo su
```
atau
```
su
```
install git terlebih dahulu (jika belum install) :
```
apt install git
```
Download atau clone repo gitnya terlebih dahulu :
```
git clone https://github.com/arifzxc/docker-pi-hole
```
masuk ke dalam directory terlebih dahulu :
```
cd docker-pi-hole/
```
Menjalankan shell script:
```
sh pi-hole.sh
```
<b>Selesai, untuk cara mengaksesnya bisa scroll ke bawah.</b>


<b><h2> 2. Dengan command line copy paste manual, silahkan ikuti perintah dibawah ini. </b></h2>
tambah repo
```
wget https://download.docker.com/linux/debian/gpg
apt-key add gpg
nano /etc/apt/sources.list.d/docker.list
```
masukan
```
deb [arch=arm64] https://download.docker.com/linux/debian bullseye stable
```
update repo
```
sudo apt update 
```

Download bahan-bahan docker
```
sudo apt install apache2 php php-xmlrpc php-mysql php-gd php-cli php-curl docker.io docker-compose -y
```
Install docker webui
```
docker pull portainer/portainer
mkdir /opt/portainer /data
```
Jalankan docker
```
docker run -d -p 9000:9000 --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /opt/portainer:/data portainer/portainer
```
Bikin file <b>.yml</b>
```
vi docker-compose.yml
```
atau 
```
nano docker-compose.yml
```
Masukan source code dibawah ini, dan simpan file.
```
version: "3"

services:
  pihole:
    container_name: pihole
    image: pihole/pihole:latest
    # For DHCP it is recommended to remove these ports and instead add: network_mode: "host"
    ports:
      - "53:53/tcp"
      - "53:53/udp"
      - "67:67/udp" # Only required if you are using Pi-hole as your DHCP server
      - "8080:80/tcp"
    environment:
      TZ: 'Asia/Jakarta'
      # WEBPASSWORD: 'set a secure password here or it will be random'
    # Volumes store your data between container upgrades
    volumes:
      - './etc-pihole:/etc/pihole'
      - './etc-dnsmasq.d:/etc/dnsmasq.d'
    #   https://github.com/pi-hole/docker-pi-hole#note-on-capabilities
    cap_add:
      - NET_ADMIN # Required if you are using Pi-hole as your DHCP server, else not needed
    restart: unless-stopped
```

Jalankan perintah dibawah ini untuk menginstall dan menjalankan pi-hole
```
docker-compose up -d
```

<b><h2>UNTUK AKSES DOCKER PORTAINTER</b></h2>
Sesuaikan dengan ip address yang didapat perangkat, dan masukan port 9000
```
contoh: 
ip-address:9000
192.168.1.55:9000
```
- Set user & password untuk mengakses docker portainer.
- Pilih docker local (biasanya paling kiri sendiri) terus klik connect. 

<b><h2>UNTUK AKSES PI-HOLE</b></h2>
Sesuaikan dengan ip address yang didapat perangkat, masukan port 8080 dan beri <b>/admin</b>
```
contoh: 
ip-address:8080/admin
192.168.1.55:8080/admin
```
Untuk password bisa request password random, dengan perintah:
```
docker logs pihole | grep random
```
Untuk membuat password sendiri, dengan perintah:<br>
masuk ke konsol container terlebih dahulu.
```
sudo docker exec -it pihole /bin/bash
```
Membuat password sendiri, dengan perintah:
```
pihole -a -p
```
Kemudian masukan password yang ingin dibuat, selanjutnya bisa digunakan untuk masuk diweb admin pi-hole.

Jika ingin menambahkan list adsblock (optional)

Masuk menu: 
- Adlists > tambahkan address: https://dbl.oisd.nl/ > Add
- Tools > Update Gravity > Update (tunggu sampai <b>Success!</b>)


Selesai.


