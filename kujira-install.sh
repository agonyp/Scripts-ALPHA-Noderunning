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

sleep 2


if [ ! $NODENAME ]; then
	read -p "Введите моникер ноды: " NODENAME < /dev/tty
	echo 'export NODENAME='$NODENAME >> $HOME/.bash_profile
fi
echo "export WALLET=kujirawallet" >> $HOME/.bash_profile
echo "export CHAIN_ID=harpoon-3" >> $HOME/.bash_profile
source $HOME/.bash_profile

echo '================================================='
echo -e "Моникер ноды: \e[1m\e[32m$NODENAME\e[0m"
echo -e "Сеть: \e[1m\e[32m$CHAIN_ID\e[0m"
echo '================================================='
sleep 2

echo -e "\e[1m\e[32m1. Обновляем пакеты... \e[0m" && sleep 1

sudo apt update && sudo apt upgrade -y

echo -e "\e[1m\e[32m2. Устанавливаем требуемые пакеты... \e[0m" && sleep 1

sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony liblz4-tool -y


ver="1.18.2"
cd $HOME
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bash_profile
source $HOME/.bash_profile
go version

echo -e "\e[1m\e[32m3. Качаем и компилируем ноду... \e[0m" && sleep 1
cd $HOME
git clone https://github.com/Team-Kujira/core $HOME/kujira-core
cd $HOME/kujira-core
make install
echo $(kujirad version) && sleep 1

echo -e "\e[1m\e[32m3. Конфигурируем ноду... \e[0m" && sleep 1
kujirad init "${NODENAME}" --chain-id ${CHAIN_ID}



wget https://raw.githubusercontent.com/Team-Kujira/networks/master/testnet/harpoon-3.json -O $HOME/.kujira/config/genesis.json

wget https://raw.githubusercontent.com/Team-Kujira/networks/master/testnet/addrbook.json -O $HOME/.kujira/config/addrbook.json


pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="10"

sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.kujirad/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.kujirad/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.kujirad/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.kujirad/config/app.toml

echo -e "\e[1m\e[32m4. Запускаем системную службу... \e[0m" && sleep 1

tee $HOME/kujirad.service > /dev/null <<EOF
[Unit]
Description=Kujira Daemon
After=network.target

[Service]
Type=simple
User=$USER
ExecStart=$(which kujirad) start --log_level error 
Restart=on-abort

[Install]
WantedBy=multi-user.target

[Service]
LimitNOFILE=65535 
EOF

sudo mv $HOME/kujirad.service /etc/systemd/system/


sudo systemctl daemon-reload
sudo systemctl enable kujirad
sudo systemctl restart kujirad

echo 'alias kujira_log="journalctl -u kujirad -f -o cat"' >> $HOME/.bash_profile
echo 'alias kujira_sync_stat="curl -s localhost:26657/status | jq .result.sync_info"' >> $HOME/.bash_profile


echo '=============== УСТАНОВКА ЗАВЕРШЕНА ==================='
echo -e 'Выполните команду: \e[1m\e[32source $HOME/.bash_profile \e[0m'
echo -e 'Проверка логов: \e[1m\e[32mkujira_log \e[0m'
echo -e 'Проверка синхронизации: \e[1m\e[32m kujira_sync_stat \e[0m'
echo -e 'Создаем кошелек: \e[1m\e[32m kujirad keys add $WALLET \e[0m'