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
echo -e "\e[1;32m ?????????????????? ???????????? ?? ??????????????...\e[0m"
sudo apt update && sudo apt upgrade -y
echo -e "\e[1;32m ?????????????????????????? ?????????????????? ????????????...\e[0m"
sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu -y
echo -e "\e[1;32m ?????????????????????????? GO...\e[0m"
cd $HOME
ver="1.17.2"
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile
echo -e "\e[1;32m ???????????? ?? ?????????????????????? ????????...\e[0m"
cd $HOME
git clone https://github.com/celestiaorg/celestia-app
cd celestia-app
git fetch
git checkout v0.6.0
make install

cd $HOME


CELESTIA_CHAIN="mamaki"
read -p "?????????????? ?????? ????????: " CELESTIA_NODENAME < /dev/tty
read -p "?????????????? ?????? ????????????????: " CELESTIA_WALLET < /dev/tty

echo '================================================='
echo -e "?????? ????????: \e[1m\e[32m$CELESTIA_NODENAME\e[0m"
echo -e "?????? ????????????????: \e[1m\e[32m$CELESTIA_WALLET\e[0m"
echo -e "?????? ????????: \e[1m\e[32m$CELESTIA_CHAIN\e[0m"
echo -e '================================================='

echo "
export CELESTIA_CHAIN=${CELESTIA_CHAIN}
export CELESTIA_NODENAME=${CELESTIA_NODENAME}
export CELESTIA_WALLET=${CELESTIA_WALLET}
" >> $HOME/.bash_profile && source $HOME/.bash_profile


echo -e "\e[1;32m ???????????????????????????? ?? ?????????????????????????? ????????...\e[0m"
celestia-appd init $CELESTIA_NODENAME --chain-id $CELESTIA_CHAIN

celestia-appd config chain-id $CELESTIA_CHAIN
celestia-appd config keyring-backend test


wget -O $HOME/.celestia-app/config/genesis.json "https://github.com/celestiaorg/networks/raw/master/mamaki/genesis.json"


peers=$(curl -sL https://raw.githubusercontent.com/celestiaorg/networks/master/mamaki/peers.txt | tr -d '\n' | head -c -1) && echo $peers
sed -i.bak -e "s/^persistent-peers *=.*/persistent-peers = \"$peers\"/" $HOME/.celestia-app/config/config.toml

bpeers="c9e17ca0213ab914df984ed496382c8f41611053@89.58.45.204:26656"
sed -i.bak -e "s/^bootstrap-peers *=.*/bootstrap-peers = \"$bpeers\"/" $HOME/.celestia-app/config/config.toml

sed -i.bak -e "s/^timeout-commit *=.*/timeout-commit = \"25s\"/" $HOME/.celestia-app/config/config.toml
sed -i.bak -e "s/^skip-timeout-commit *=.*/skip-timeout-commit = false/" $HOME/.celestia-app/config/config.toml

sed -i.bak -e "s/^skip-timeout-commit *=.*/skip-timeout-commit = false/" $HOME/.celestia-app/config/config.toml


sed -i.bak -e "s/^mode *=.*/mode = \"validator\"/" $HOME/.celestia-app/config/config.toml

echo -e "\e[1;32m ?????????????? ?????????????????? ???????? ?? ?????????????????? ????????????...\e[0m"
tee $HOME/celestia-appd.service > /dev/null <<EOF
[Unit]
  Description=CELESTIA MAMAKI
  After=network-online.target
[Service]
  User=$USER
  ExecStart=$(which celestia-appd) start
  Restart=on-failure
  RestartSec=10
  LimitNOFILE=65535
[Install]
  WantedBy=multi-user.target
EOF

sudo mv $HOME/celestia-appd.service /etc/systemd/system/

sudo systemctl enable celestia-appd
sudo systemctl daemon-reload
sudo systemctl restart celestia-appd

echo 'alias celestia_log="journalctl -u celestia-appd -f -o cat"' >> $HOME/.bash_profile
echo 'alias celestia_sync_stat="curl -s localhost:26657/status | jq .result.sync_info"' >> $HOME/.bash_profile

echo '=============== ?????????????????? ?????????????????? ==================='
echo -e '???????????????? ??????????: \e[1m\e[32mcelestia_log \e[0m'
echo -e '?????????????????? ???????????? ??????????????????????????: \e[1m\e[32mcelestia_stats_sync \e[0m'
echo -e '?????????? ?????????????????? ??????????????????: \e[1m\e[32msource $HOME/.bash_profile \e[0m'