#!/bin/bash
echo "==========================================="
echo "##############+++++++++++++++##############";
echo "#########=+++++++*#######*+++++++=#########";
echo "#######+++++###################+++++#######";
echo "#####++++#########################++++#####";
echo "###++++###++###################++###++++###";
echo "##+++#####++++=#############=++++#####+++##";
echo "#+++######+++++++++++++++++++++++######+++#";
echo "+++#######%+++++++++++++++++++++:#######+++";
echo "+++########+++++++++++++++++++++########+++";
echo "++########+++++++++++++++++++++++########++";
echo "++#######+++++++++++++++++++++++++#######++";
echo "++######+++++++++++++++++++++++++++######++";
echo "+++#######+++++++++++++++++++++++#######+++";
echo "+++#########+++++++++++++++++++#########+++";
echo "#+++##########+++++++++++++++##########+++#";
echo "##+++##########+++++++++++++##########+++##";
echo "###++++#########+++++++++++#########++++###";
echo "#####++++########+++++++++########++++#####";
echo "#######+++++###################+++++#######";
echo "#########=+++++++*#######*+++++++*#########";
echo "##############+++++++++++++++##############";
echo "==========================================="

sleep 2


if [ ! $NODENAME ]; then
	read -p "Введите имя ноды: " NODENAME < /dev/tty
	echo 'export NODENAME='$NODENAME >> $HOME/.bash_profile
fi
echo "export WALLET=wallet" >> $HOME/.bash_profile
echo "export CHAIN_ID=sei-testnet-1" >> $HOME/.bash_profile
source $HOME/.bash_profile

echo '================================================='
echo -e "Имя ноды: \e[1m\e[32m$NODENAME\e[0m"
echo -e "Ваш кошелек: \e[1m\e[32m$WALLET\e[0m"
echo -e "Имя сети: \e[1m\e[32m$CHAIN_ID\e[0m"
echo -e '================================================='
sleep 2

echo -e "\e[1m\e[32m1. Обновляем приложения... \e[0m" && sleep 1

sudo apt update && sudo apt upgrade -y

echo -e "\e[1m\e[32m2. Устанвливаем требуемые приложения... \e[0m" && sleep 1

sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony liblz4-tool -y </dev/null


ver="1.17.2"
cd $HOME
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bash_profile
source ~/.bash_profile
go version

echo -e "\e[1m\e[32m3. Качаем и компилируем ноду... \e[0m" && sleep 1

cd $HOME
git clone https://github.com/sei-protocol/sei-chain.git
cd sei-chain
git checkout 1.0.0beta
go build -o build/seid ./cmd/sei-chaind
chmod +x ./build/seid && sudo mv ./build/seid /usr/local/bin/seid


seid config chain-id $CHAIN_ID
seid config keyring-backend file


seid init $NODENAME --chain-id $CHAIN_ID


wget -qO $HOME/.sei-chain/config/genesis.json "https://raw.githubusercontent.com/sei-protocol/testnet/master/sei-testnet-1/genesis.json"
wget -qO $HOME/.sei-chain/config/addrbook.json "https://raw.githubusercontent.com/sei-protocol/testnet/master/sei-testnet-1/addrbook.json"


sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0usei\"/" $HOME/.sei-chain/config/app.toml

SEEDS=""
PEERS="27aab76f983cd7c6558f1dfc50b919daaef14555@3.22.112.181:26656,39c4bcaded0d1d886f2788ae955f1939406f3e7d@65.108.198.54:26696,2f2804434afda302c86eb89eca27503e49a8a260@65.21.131.215:26696,6f71bcbe347069fc4df9b607f6b843226e8deb71@95.217.221.201:26656,2f047e234cb8b99fe8b9fee0059a5bc45042bc97@95.216.84.188:26656,3cd0ccddaba6c662fb5f4836456f448f13653587@212.125.21.178:45656,9db58dba3b6354177fb428caccf5167c616ad4a1@167.235.28.18:26656,38b4d78c7d6582fb170f6c19330a7e37e6964212@194.163.189.114:46656"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.sei-chain/config/config.toml

sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.sei-chain/config/config.toml

pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="10"

sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.sei-chain/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.sei-chain/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.sei-chain/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.sei-chain/config/app.toml

seid tendermint unsafe-reset-all

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

echo '=============== УСТАНОВКА ЗАВЕРШЕНА ==================='
echo -e 'To check logs: \e[1m\e[32mjournalctl -u seid -f -o cat \e[0m'
echo -e 'To check sync status: \e[1m\e[32mcurl -s localhost:26657/status | jq .result.sync_info \e[0m'