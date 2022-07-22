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
echo "export CHAIN_ID=sei-atlantic-1" >> $HOME/.bash_profile
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
git checkout 1.0.7beta-postfix
cd sei-chain/
make install
chmod +x ./build/seid && sudo mv ./build/seid /usr/local/bin/seid


seid config chain-id $CHAIN_ID
seid config keyring-backend file


seid init $NODENAME --chain-id $CHAIN_ID



curl https://raw.githubusercontent.com/sei-protocol/testnet/master/sei-incentivized-testnet/genesis.json > ~/.sei/config/genesis.json

curl https://raw.githubusercontent.com/sei-protocol/testnet/master/sei-incentivized-testnet/addrbook.json > ~/.sei/config/addrbook.json

sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0usei\"/" $HOME/.sei/config/app.toml

SEEDS="df1f6617ff5acdc85d9daa890300a57a9d956e5e@sei-atlantic-1.seed.rhinostake.com:16660"
PEERS="22991efaa49dbaae857669d44cb564406a244811@18.222.18.162:26656,a37d65086e78865929ccb7388146fb93664223f7@18.144.13.149:26656,873a358b46b07c0c7c0280397a5ad27954a10633@141.95.175.196:26656,e66f9a9cab4428bfa3a7f32abbedbc684e734a48@185.193.17.129:12656,16225e262a0d38fe73073ab199f583e4a607e471@135.181.59.162:19656,2efd524f097b3fef2d26d0031fda21a72a51a765@38.242.213.174:12656,3b5ae3a1691d4ed24e67d7fe1499bc081c3ad8b0@65.108.131.189:20956,ad6d30dc6805df4f48b49d9013bbb921a5713fa6@20.211.82.153:26656,4e53c634e89f7b7ecff98e0d64a684269403dd78@38.242.235.141:26656,da5f6fcd1cd2ba8c7de8a06fb3ab56ab6a8157cf@38.242.235.142:26656,89e7d8c9eefc1c9a9b3e1faff31c67e0674f9c08@165.227.11.230:26656,94b6fa7ae5554c22e81a81e4a0928c48e41801d8@88.99.3.158:10956,b95aa07e60928fbc5ba7da9b6fe8c51798bd40be@51.250.6.195:26656,94b72206c0b0007494e20e2f9b958cd57e970d48@209.145.50.102:26656,94cf3893ded18bc6e3991d5add88449cd3f6c297@65.108.230.75:26656,82de728de0d663c03a820e570b94adac19c09adf@5.9.80.215:26656,5e1f8ccfa64dfd1c17e3fdac0dbf50f5fcc1acc3@209.126.7.113:26656,6a5113e8412f68bbeab733bb1297a0a38f884f7c@162.55.80.116:26656,7c95b2eec599369bebb8281b960589dc2857548a@164.215.102.44:26656,4bf8aa7b80f4db8a6f2abf5d757c9cab5d3f4d85@188.40.98.169:26656,9e38cf7ccb898632482a09b26ecba3f7e1a9e300@51.75.135.46:26656,641eea8d26c4b3b479b95a2cb4bd04712f3eda29@135.181.249.71:12656,8625abf6079da0e3326b0ad74c9c0e263af39654@137.184.44.146:12656,11c84300b4417af7e6c081f413003176b33b3877@51.75.135.47:26656,8a349512cf1ce179a126cb8762aea955ca1a261f@195.201.243.40:26651,6c27c768936ff8eebde94fe898b54df71f936e48@47.156.153.124:56656,7f037abdf485d02b95e50e9ba481166ddd6d6cae@185.144.99.65:26656,90916e0b118f2c00e90a40a0180b275261b547f2@65.108.72.121:26656,02be57dc6d6491bf272b823afb81f24d61243e1e@141.94.139.233:26656,ed3ec09ab24b8fcf0a36bc80de4b97f1e379d346@38.242.206.198:26656,7caa7add8d8a279e2da67a72700ab2d4540fbc08@34.97.43.89:12656,cce4c3526409ec516107db695233f9b047d52bf6@128.199.59.125:36376,3f6e68bd476a7cd3f491105da50306f8ebb74643@65.21.143.79:21156"
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
