#!/bin/bash
git clone https://github.com/sei-protocol/sei-chain.git
cd sei-chain/
git fetch --tags -f
git checkout 1.0.3beta

make install

sudo systemctl restart seid