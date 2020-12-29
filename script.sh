#!/bin/bash

touch /tmp/keepalive

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

cd ~

docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker rmi $(docker images -q)

sudo mkdir /mnt/offline

sudo /usr/bin/rclone mount google:offline /mnt/offline --allow-non-empty &

docker run -d --name aria2-pro --restart unless-stopped --log-opt max-size=1m -e PUID=$UID -e PGID=$GID -e UMASK_SET=022 -e RPC_SECRET=yqxhwg3866 -e RPC_PORT=6800 -p 6800:6800 -e LISTEN_PORT=6888 -p 6888:6888 -p 6888:6888/udp -e IPV6_MODE=true -v $PWD/aria2-config:/config -v $PWD/aria2-downloads:/downloads -v /mnt/offline:/offline p3terx/aria2-pro:latest

