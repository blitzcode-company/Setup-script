#!/bin/bash

echo "Instalando Node.js y npm..."  

yum install -y gcc-c++ make

curl -fsSL https://rpm.nodesource.com/setup_20.x | sudo bash -
sudo yum install -y nodejs
echo "Node.js y npm instalados."