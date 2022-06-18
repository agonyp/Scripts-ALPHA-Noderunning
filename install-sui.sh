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
	read -p "Введите имя ноды: " NODENAME < /dev/tty
	echo 'export NODENAME='$NODENAME >> $HOME/.bash_profile
fi
echo "export WALLET=wallet" >> $HOME/.bash_profile
echo "export CHAIN_ID=sei-testnet-2" >> $HOME/.bash_profile
source $HOME/.bash_profile

echo '================================================='
echo -e "Имя ноды: \e[1m\e[32m$NODENAME\e[0m"
#echo -e "Ваш кошелек: \e[1m\e[32m$WALLET\e[0m"
echo -e "Имя сети: \e[1m\e[32m$CHAIN_ID\e[0m"
echo -e '================================================='
sleep 2

echo -e "\e[1m\e[32m1. Обновляем приложения... \e[0m" && sleep 1

sudo apt update && sudo apt upgrade -y

echo -e "\e[1m\e[32m2. Устанвливаем требуемые приложения... \e[0m" && sleep 1

sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony liblz4-tool -y </dev/null


ver="1.18.2"
cd $HOME || exit
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bash_profile
source $HOME/.bash_profile
go version

echo -e "\e[1m\e[32m3. Качаем и компилируем ноду... \e[0m" && sleep 1

cd $HOME || exit
git clone https://github.com/sei-protocol/sei-chain.git
cd sei-chain || exit
git checkout 1.0.2beta
go build -o build/seid ./cmd/seid
chmod +x ./build/seid && sudo mv ./build/seid /usr/local/bin/seid


seid config chain-id $CHAIN_ID
seid config keyring-backend file


seid init $NODENAME --chain-id $CHAIN_ID


wget -qO $HOME/.sei/config/genesis.json "https://raw.githubusercontent.com/sei-protocol/testnet/master/sei-testnet-2/genesis.json"
wget -qO $HOME/.sei/config/addrbook.json "https://raw.githubusercontent.com/agonyp/Scripts-ALPHA-Noderunning/main/utilities/sei-addrbook.json"


sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0usei\"/" $HOME/.sei/config/app.toml

SEEDS=""
PEERS=""
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.sei/config/config.toml

sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.sei/config/config.toml

pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="10"

sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.sei/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.sei/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.sei/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.sei/config/app.toml

seid unsafe-reset-all

echo -e "\e[1m\e[32m4. Запускаем сервис... \e[0m" && sleep 1

tee $HOME/seid.service > /dev/null <<EOF
[Unit]
Description=seid
After=network.target
[Service]
Type=simple
User=$USER
ExecStart=$(which seid) start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF

sudo mv $HOME/seid.service /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl enable seid
sudo systemctl restart seid

echo 'alias sei_logs="sudo journalctl -u seid -f -o cat"' >> $HOME/.bash_profile
echo 'alias sei_stats_sync="curl -s localhost:26657/status | jq .result.sync_info"' >> $HOME/.bash_profile
echo 'alias sei_wallet_balance="seid query bank balances $WALLET_ADDRESS"' >> $HOME/.bash_profile
echo 'alias sei_faucet="curl -X POST -d '{"'"address"'": '"'"'"'"''$WALLET_ADDRESS''"'"'"'"', "'"coins"'": ["'"1000000usei"'"]}' http://3.22.112.181:8000"' >> $HOME/.bash_profile

echo '=============== УСТАНОВКА ЗАВЕРШЕНА ==================='
echo -e 'Проверка логов: \e[1m\e[32msei_logs \e[0m'
echo -e 'Проверить статус синхронизации: \e[1m\e[32msei_stats_sync \e[0m'
