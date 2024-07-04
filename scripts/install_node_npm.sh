#!/bin/bash
if ! command -v curl &> /dev/null; then
    sudo yum install -y curl
fi



sudo yum install epel-release -y

sudo yum install -y libstdc++ libm

export LD_LIBRARY_PATH=/usr/lib:/lib:$LD_LIBRARY_PATH


curl -fsSL https://rpm.nodesource.com/setup_20.x | sudo bash -
sudo yum install -y --skip-broken nodejs

node -v

npm -v


echo "Node.js y npm instalados."