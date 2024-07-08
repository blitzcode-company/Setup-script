#!/bin/bash

if ! command -v curl &> /dev/null; then
    sudo dnf install -y curl
fi

sudo dnf install -y epel-release

sudo dnf install -y libstdc++ libm

export LD_LIBRARY_PATH=/usr/lib:/lib:$LD_LIBRARY_PATH

curl -fsSL https://rpm.nodesource.com/setup_20.x | sudo bash -
sudo dnf install -y --skip-broken nodejs

node -v
npm -v

echo "Node.js y npm instalados."