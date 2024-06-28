#!/bin/bash

echo "Instalando Node.js y npm..."
curl -sL https://rpm.nodesource.com/setup_14.x | sudo bash -
sudo yum install -y nodejs
echo "Node.js y npm instalados."