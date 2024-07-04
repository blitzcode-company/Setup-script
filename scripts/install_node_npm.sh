#!/bin/bash

echo "Instalando Node.js y npm..."  
git clone https://github.com/nodejs/node
cd node

git checkout v20.11.0

./configure
make -j4

sudo make install

node -v
npm -v

echo "Node.js y npm instalados."