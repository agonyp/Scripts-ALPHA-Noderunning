#!/bin/bash
sudo mv ~/.cargo/bin/nomic /usr/local/bin/

nomic init
external_address="11.11.11.11:26656"
sed -i.bak -e "s/^external_address =.*/external_address = \"$external_address\"/" ~/.nomic-stakenet/tendermint/config/config.toml
seeds="238120dfe716082754048057c1fdc3d6f09609b5@161.35.51.124:26656,a67d7a4d90f84d5c67bfc196aac68441ba9484a6@167.99.119.196:26659"
sed -i.bak -e "s/^seeds =.*/seeds = \"$seeds\"/" ~/.nomic-stakenet/tendermint/config/config.toml

tee $HOME/nomic.service > /dev/null <<EOF
[Unit]
  Description=NOMIC
  After=network-online.target
[Service]
  User=$USER
  ExecStart=$(which nomic) start
  Restart=on-failure
  RestartSec=10
  LimitNOFILE=65535
[Install]
  WantedBy=multi-user.target
EOF