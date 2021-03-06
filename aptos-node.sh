#!/bin/bash
cd $HOME

sudo apt update && sudo apt upgrade

sudo apt install -y wget unzip ca-certificates curl gnupg lsb-release </dev/null

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y </dev/null

sudo chmod 666 /var/run/docker.sock

wget https://github.com/aptos-labs/aptos-core/releases/download/aptos-cli-v0.1.1/aptos-cli-0.1.1-Ubuntu-x86_64.zip 

unzip aptos-cli-0.1.1-Ubuntu-x86_64.zip
sudo mv aptos /bin/
chmod +x /bin/aptos

export WORKSPACE=testnet
mkdir ~/$WORKSPACE
cd ~/$WORKSPACE

wget https://raw.githubusercontent.com/aptos-labs/aptos-core/main/docker/compose/aptos-node/docker-compose.yaml &&
wget https://raw.githubusercontent.com/aptos-labs/aptos-core/main/docker/compose/aptos-node/validator.yaml &&
wget https://raw.githubusercontent.com/aptos-labs/aptos-core/main/docker/compose/aptos-node/fullnode.yaml

aptos genesis generate-keys --output-dir ~/$WORKSPACE

export routable_ip="$(wget -qO- eth0.me)"

read -p "Введите имя пользователя для вашей ноды:" aptos_username < /dev/tty

echo 'Ваше имя пользователя: ' $aptos_username

aptos genesis set-validator-configuration \
    --keys-dir ~/$WORKSPACE --local-repository-dir ~/$WORKSPACE \
    --username $aptos_username \
    --validator-host $routable_ip:6180 \
    --full-node-host $routable_ip:6182

sudo tee <<EOF >/dev/null ~/$WORKSPACE/layout.yaml
---
root_key: "0x5243ca72b0766d9e9cbf2debf6153443b01a1e0e6d086c7ea206eaf6f8043956"
users:
  - $aptos_username
chain_id: 23
EOF

wget https://github.com/aptos-labs/aptos-core/releases/download/aptos-framework-v0.1.0/framework.zip

unzip framework.zip

aptos genesis generate-genesis --local-repository-dir ~/$WORKSPACE --output-dir ~/$WORKSPACE

sudo docker compose up -d

echo "$(less ~/$WORKSPACE/$aptos_username.yaml)"
echo "Full node IP:" $routable_ip
echo "Full node port: 6182"
echo "/---------------------------/"
echo "Проверка логов:"
echo "docker logs -f testnet-fullnode-1"
echo "docker logs -f testnet-validator-1"
echo "Перезапуск ноды:"
echo "docker restart testnet-fullnode-1"
echo "docker restart testnet-validator-1"