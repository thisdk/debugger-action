#!/bin/bash

touch /tmp/keepalive

# delete
sudo rm -rf /root/.nuget &
sudo rm -rf /usr/local/lib/android &
sudo rm -rf /usr/local/lib/node_modules &
sudo rm -rf /usr/share/dotnet &
docker rmi $(docker images -q)

# frp
wget https://github.com/fatedier/frp/releases/download/v0.34.3/frp_0.34.3_linux_amd64.tar.gz
tar zxf frp_0.34.3_linux_amd64.tar.gz
rm frp_0.34.3_linux_amd64.tar.gz
mv ./frp_0.34.3_linux_amd64/frpc ./
rm -rf frp_0.34.3_linux_amd64
sudo ./frpc -c frpc.ini &

# rclone
sudo apt install -y fuse
sudo mkdir /root/.config/rclone
sudo mv rclone.conf /root/.config/rclone/
curl https://rclone.org/install.sh | sudo bash
sudo mkdir /mnt/offline
sudo /usr/bin/rclone mount google:offline /mnt/offline --allow-non-empty &

# aria2
cd ~
wget -N git.io/aria2.sh && chmod +x aria2.sh
wget https://raw.githubusercontent.com/thisdk/debugger-action/main/script.conf
wget https://raw.githubusercontent.com/thisdk/debugger-action/main/aria2.conf
sudo mv aria2.sh /root/
sudo mv script.conf /root/
sudo mv aria2.conf /root/
echo 1 | sudo /root/aria2.sh
sudo mv -f /root/aria2.conf /root/.aria2c/
sudo mv -f /root/script.conf /root/.aria2c/
echo -e "11\ny" | sudo /root/aria2.sh
echo 6 | sudo /root/aria2.sh
