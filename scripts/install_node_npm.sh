#!/bin/bash

echo "Instalando Node.js y npm..."  
wget https://unofficial-builds.nodejs.org/download/release/v20.13.1/node-v20.13.1-linux-x64-glibc-217.tar.gz
tar zxf node-v20.13.1-linux-x64-glibc-217.tar.gz
mv ~/opt/node ~/opt/node.old
cp -r node-v20.13.1-linux-x64-glibc-217 ~/opt/node
node -v

echo "Node.js y npm instalados."