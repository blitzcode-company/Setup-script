#!/bin/bash

echo "Instalando Node.js y npm..."  


curl -fsSL https://rpm.nodesource.com/setup_20.x | sudo bash -
sudo yum install -y nodejs
echo "Node.js y npm instalados."