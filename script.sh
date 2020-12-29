#!/bin/bash

touch /tmp/keepalive

sudo rm -rf /usr/share/dotnet &

# frp
wget https://github.com/fatedier/frp/releases/download/v0.34.3/frp_0.34.3_linux_amd64.tar.gz
tar zxf frp_0.34.3_linux_amd64.tar.gz
rm frp_0.34.3_linux_amd64.tar.gz
mv ./frp_0.34.3_linux_amd64/frpc ./
rm -rf frp_0.34.3_linux_amd64

./frpc -c frpc.ini &

sudo mkdir /root/.config/rclone

sudo mv rclone.conf /root/.config/rclone/

curl https://rclone.org/install.sh | sudo bash

sudo mkdir /mnt/offline

sudo /usr/bin/rclone mount google:offline /mnt/offline --allow-non-empty &

cd ~

wget -N git.io/aria2.sh && chmod +x aria2.sh

wget https://raw.githubusercontent.com/thisdk/debugger-action/main/script.conf

wget https://raw.githubusercontent.com/thisdk/debugger-action/main/aria2.conf

sudo mv aria2.sh /root/

sudo mv script.conf /root/

sudo mv aria2.conf /root/

docker rmi $(docker images -q)

