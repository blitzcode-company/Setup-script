#!/bin/bash

echo "Instalando Node.js y npm..."  

sudo sed -i 's/mirror.centos.org/vault.centos.org/g' /etc/yum.repos.d/*.repo
sudo sed -i 's/^#.*baseurl=http/baseurl=http/g' /etc/yum.repos.d/*.repo
sudo sed -i 's/^mirrorlist=http/#mirrorlist=http/g' /etc/yum.repos.d/*.repo

curl -fsSL https://rpm.nodesource.com/setup_20.x | sudo bash -
sudo yum install -y nodejs
echo "Node.js y npm instalados."