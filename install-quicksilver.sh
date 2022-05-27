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

# set vars
if [ ! $NODENAME ]; then
	read -p "Введите моникер ноды: " NODENAME < /dev/tty
	echo 'export NODENAME='$NODENAME >> $HOME/.bash_profile
fi
echo "export WALLET=quickwallet" >> $HOME/.bash_profile
echo "export CHAIN_ID=quicktest-3" >> $HOME/.bash_profile
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


ver="1.17.2"
cd $HOME
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bash_profile
source $HOME/.bash_profile
go version

echo -e "\e[1m\e[32m3. Качаем и компилируем ноду... \e[0m" && sleep 1
# download binary
cd $HOME
git clone https://github.com/ingenuity-build/quicksilver.git --branch v0.1.10
cd quicksilver
make build
chmod +x ./build/quicksilverd && mv ./build/quicksilverd /usr/local/bin/quicksilverd

echo -e "\e[1m\e[32m3. Конфигурируем ноду... \e[0m" && sleep 1
quicksilverd config chain-id $CHAIN_ID
quicksilverd config keyring-backend file


quicksilverd init $NODENAME --chain-id $CHAIN_ID


wget -qO $HOME/.quicksilverd/config/genesis.json "https://raw.githubusercontent.com/ingenuity-build/testnets/main/rhapsody/genesis.json"


sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0uqck\"/" $HOME/.quicksilverd/config/app.toml


SEEDS="dd3460ec11f78b4a7c4336f22a356fe00805ab64@seed.quicktest-1.quicksilver.zone:26656"
PEERS=""
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.quicksilverd/config/config.toml

sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.quicksilverd/config/config.toml


pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="10"

sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.quicksilverd/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.quicksilverd/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.quicksilverd/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.quicksilverd/config/app.toml


SNAP_RPC1="http://node02.quicktest-1.quicksilver.zone:26657" \
&& SNAP_RPC2="http://node04.quicktest-1.quicksilver.zone:26657"
LATEST_HEIGHT=$(curl -s $SNAP_RPC2/block | jq -r .result.block.header.height) \
&& BLOCK_HEIGHT=$((LATEST_HEIGHT - 2000)) \
&& TRUST_HASH=$(curl -s "$SNAP_RPC2/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)

sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1true| ; \
s|^(rpc_servers[[:space:]]+=[[:space:]]+).*$|\1\"$SNAP_RPC1,$SNAP_RPC2\"| ; \
s|^(trust_height[[:space:]]+=[[:space:]]+).*$|\1$BLOCK_HEIGHT| ; \
s|^(trust_hash[[:space:]]+=[[:space:]]+).*$|\1\"$TRUST_HASH\"|" $HOME/.quicksilverd/config/config.toml


quicksilverd unsafe-reset-all

echo -e "\e[1m\e[32m4. Запускаем системную службу... \e[0m" && sleep 1

tee $HOME/quicksilverd.service > /dev/null <<EOF
[Unit]
Description=quicksilverd
After=network.target
[Service]
Type=simple
User=$USER
ExecStart=$(which quicksilverd) start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF

sudo mv $HOME/quicksilverd.service /etc/systemd/system/


sudo systemctl daemon-reload
sudo systemctl enable quicksilverd
sudo systemctl restart quicksilverd

echo 'alias quicksilver_log="journalctl -u quicksilverd -f -o cat"' >> $HOME/.bash_profile
echo 'alias quicksilver_sync_stat="curl -s localhost:26657/status | jq .result.sync_info"' >> $HOME/.bash_profile


echo '=============== УСТАНОВКА ЗАВЕРШЕНА ==================='
echo -e 'Проверка логов: \e[1m\e[32mquicksilver_log \e[0m'
echo -e 'Проверка синхронизации: \e[1m\e[32m quicksilver_sync_stat \e[0m'
echo -e 'Создаем кошелек: \e[1m\e[32m quicksilverd keys add $WALLET \e[0m'