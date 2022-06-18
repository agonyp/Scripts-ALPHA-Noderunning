#!/bin/bash
printf "\n"
echo -e "==========================================="
echo -e "\e[1;30m##############\e[0m\e[1;35m+++++++++++++++\e[0m\e[1;30m##############\e[0m";
echo -e "\e[1;30m#########\e[0m\e[1;35m=+++++++*\e[0m\e[1;30m#######\e[1;35m*+++++++=\e[0m\e[1;30m#########\e[0m";
echo -e "\e[1;30m#######\e[0m\e[1;35m+++++\e[0m\e[1;30m###################\e[1;35m+++++\e[0m\e[1;30m#######\e[0m";
echo -e "\e[1;30m#####\e[0m\e[1;35m++++\e[0m\e[1;30m#########################\e[1;35m++++\e[0m\e[1;30m#####\e[0m";
echo -e "\e[1;30m###\e[0m\e[1;35m++++\e[0m\e[1;30m###\e[1;36m++\e[0m\e[1;30m###################\e[1;36m++\e[0m\e[1;30m###\e[1;35m++++\e[0m\e[1;30m###\e[0m";
echo -e "\e[1;30m##\e[0m\e[1;35m+++\e[0m\e[1;30m#####\e[1;36m++++\e[0m\e[1;30m=#############=\e[1;36m++++\e[0m\e[1;30m#####\e[1;35m+++\e[0m\e[1;30m##\e[0m";
echo -e "\e[1;30m#\e[0m\e[1;35m+++\e[0m\e[1;30m######\e[1;36m+++++++++++++++++++++++\e[0m\e[1;30m######\e[1;35m+++\e[0m\e[1;30m#\e[0m";
echo -e "\e[1;35m+++\e[0m\e[1;30m#######%\e[1;36m+++++++++++++++++++++\e[0m\e[1;30m:#######\e[1;35m+++\e[0m";
echo -e "\e[1;35m+++\e[0m\e[1;30m########\e[1;36m+++++++++++++++++++++\e[0m\e[1;30m########\e[1;35m+++\e[0m";
echo -e "\e[1;35m++\e[0m\e[1;30m########\e[1;36m+++++++++++++++++++++++\e[0m\e[1;30m########\e[1;35m++\e[0m";
echo -e "\e[1;35m++\e[0m\e[1;30m#######\e[1;36m+++++++++++++++++++++++++\e[0m\e[1;30m#######\e[1;35m++\e[0m";
echo -e "\e[1;35m++\e[0m\e[1;30m######\e[1;36m+++++++++++++++++++++++++++\e[0m\e[1;30m######\e[1;35m++\e[0m";
echo -e "\e[1;35m+++\e[0m\e[1;30m#######\e[1;36m+++++++++++++++++++++++\e[0m\e[1;30m#######\e[1;35m+++\e[0m";
echo -e "\e[1;35m+++\e[0m\e[1;30m#########\e[1;36m+++++++++++++++++++\e[0m\e[1;30m#########\e[1;35m+++\e[0m";
echo -e "\e[1;30m#\e[0m\e[1;35m+++\e[0m\e[1;30m##########\e[1;36m+++++++++++++++\e[0m\e[1;30m##########\e[1;35m+++\e[0m\e[1;30m#\e[0m";
echo -e "\e[1;30m##\e[0m\e[1;35m+++\e[0m\e[1;30m##########\e[1;36m+++++++++++++\e[0m\e[1;30m##########\e[1;35m+++\e[0m\e[1;30m##\e[0m";
echo -e "\e[1;30m###\e[0m\e[1;35m++++\e[0m\e[1;30m#########\e[1;36m+++++++++++\e[0m\e[1;30m#########\e[1;35m++++\e[0m\e[1;30m###\e[0m";
echo -e "\e[1;30m#####\e[0m\e[1;35m++++\e[0m\e[1;30m########\e[1;36m+++++++++\e[0m\e[1;30m########\e[1;35m++++\e[0m\e[1;30m#####\e[0m";
echo -e "\e[1;30m#######\e[0m\e[1;35m+++++\e[0m\e[1;30m###################\e[1;35m+++++\e[0m\e[1;30m#######\e[0m";
echo -e "\e[1;30m#########\e[0m\e[1;35m=+++++++*\e[0m\e[1;30m#######\e[1;35m*+++++++*\e[0m\e[1;30m#########\e[0m";
echo -e "\e[1;30m##############\e[0m\e[1;35m+++++++++++++++\e[0m\e[1;30m##############\e[0m";
echo -e "==========================================="
echo -e "\e[1;32m Обновляем пакеты в системе...\e[0m"
sudo apt update && sudo apt upgrade -y
echo -e "\e[1;32m Устанавливаем Docker...\e[0m" && sleep 1
sudo apt install -y wget unzip ca-certificates curl gnupg lsb-release </dev/null
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y </dev/null
sudo chmod 666 /var/run/docker.sock
echo -e "==========================================="
echo -e "Нам понадобиться кошелек, расширение для браузера - \e[1;32m https://polkadot.js.org/extension/ \e[0m" && sleep 1
read -p "Введите адрес вашего кошелька: " WALLET_SUBSPACE < /dev/tty
read -p "Введите моникер для вашей ноды: " NODE_ID < /dev/tty
echo -e "\e[1;32mПримеры значений размера плота - 100G это 100 гигабайт, 1T это 1 терабайт! \e[0m"
read -p "Введите размер плота: " PLOT_SIZE < /dev/tty
echo '================================================='
echo -e "Моникер: \e[1m\e[32m$NODE_ID\e[0m"
echo -e "Адрес кошелька: \e[1m\e[32m$WALLET_SUBSPACE\e[0m"
echo -e "Размер плота: \e[1m\e[32m$PLOT_SIZE\e[0m"
echo -e '================================================='
echo "
export NODE_ID=${NODE_ID}
export WALLET_SUBSPACE=${WALLET_SUBSPACE}
export PLOT_SIZE=${PLOT_SIZE}
" >> $HOME/.bash_profile && source $HOME/.bash_profile

mkdir $HOME/subspace

sudo tee <<EOF >/dev/null $HOME/subspace/docker-compose.yml
version: "3.7"
services:
  node:
    image: ghcr.io/subspace/node:gemini-1b-2022-jun-18
    volumes:
      - node-data:/var/subspace:rw
#      - /path/to/subspace-node:/var/subspace:rw
    ports:
      - "0.0.0.0:30333:30333"
    restart: unless-stopped
    command: [
      "--chain", "gemini-1",
      "--base-path", "/var/subspace",
      "--execution", "wasm",
      "--pruning", "1024",
      "--keep-blocks", "1024",
      "--port", "30333",
      "--rpc-cors", "all",
      "--rpc-methods", "safe",
      "--unsafe-ws-external",
      "--validator",
      "--name", "$NODE_ID"
    ]
    healthcheck:
      timeout: 5s
      interval: 30s
      retries: 5

  farmer:
    depends_on:
      node:
        condition: service_healthy

    image: ghcr.io/subspace/farmer:gemini-1b-2022-jun-18

    volumes:
      - farmer-data:/var/subspace:rw
#      - /path/to/subspace-farmer:/var/subspace:rw
    restart: unless-stopped
    command: [
      "--base-path", "/var/subspace",
      "farm",
      "--node-rpc-url", "ws://node:9944",
      "--ws-server-listen-addr", "0.0.0.0:9955",
      "--reward-address", "$WALLET_SUBSPACE",
      "--plot-size", "$PLOT_SIZE"
    ]
volumes:
  node-data:
  farmer-data:
EOF

cd $HOME/subspace
 
docker compose up -d
echo '=============== УСТАНОВКА ЗАВЕРШЕНА ==================='
echo -e 'Проверка логов ноды: \e[1m\e[32mdocker logs subspace-node-1 \e[0m'
echo -e 'Проверка логов фармера: \e[1m\e[32mdocker logs subspace-farmer-1 \e[0m'