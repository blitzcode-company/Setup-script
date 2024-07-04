#!/bin/bash
if ! command -v curl &> /dev/null; then
    sudo yum install -y curl
fi


sudo yum install epel-release -y

curl -fsSL https://rpm.nodesource.com/setup_20.x | sudo bash -
sudo yum install -y --skip-broken nodejs

node -v

npm -v


echo "Node.js y npm instalados."