#!/bin/bash
sudo apt update && sudo apt upgrade -y

sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu -y

cd $HOME
ver="1.17.2"
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile

cd $HOME
git clone https://github.com/celestiaorg/celestia-app
cd celestia-app
git fetch
git checkout v0.5.0
make install

cd $HOME

# set vars
CELESTIA_CHAIN="mamaki"
read -p "Введите имя ноды: " CELESTIA_NODENAME < /dev/tty
read -p "Введите имя кошелька: " CELESTIA_WALLET < /dev/tty

echo "
export CELESTIA_CHAIN=${CELESTIA_CHAIN}
export CELESTIA_NODENAME=${CELESTIA_NODENAME}
export CELESTIA_WALLET=${CELESTIA_WALLET}
" >> $HOME/.bash_profile && source $HOME/.bash_profile


# do init
celestia-appd init $CELESTIA_NODENAME --chain-id $CELESTIA_CHAIN

celestia-appd config chain-id $CELESTIA_CHAIN
celestia-appd config keyring-backend test

# download genesis
wget -O $HOME/.celestia-app/config/genesis.json "https://github.com/celestiaorg/networks/raw/master/mamaki/genesis.json"

# config
peers=$(curl -sL https://raw.githubusercontent.com/celestiaorg/networks/master/mamaki/peers.txt | tr -d '\n' | head -c -1) && echo $peers
sed -i.bak -e "s/^persistent-peers *=.*/persistent-peers = \"$peers\"/" $HOME/.celestia-app/config/config.toml

bpeers="f0c58d904dec824605ac36114db28f1bf84f6ea3@144.76.112.238:26656"
sed -i.bak -e "s/^bootstrap-peers *=.*/bootstrap-peers = \"$bpeers\"/" $HOME/.celestia-app/config/config.toml

sed -i.bak -e "s/^timeout-commit *=.*/timeout-commit = \"25s\"/" $HOME/.celestia-app/config/config.toml
sed -i.bak -e "s/^skip-timeout-commit *=.*/skip-timeout-commit = false/" $HOME/.celestia-app/config/config.toml

# mode validator if gonna create validator
sed -i.bak -e "s/^mode *=.*/mode = \"validator\"/" $HOME/.celestia-app/config/config.toml

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