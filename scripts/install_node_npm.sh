#!/bin/bash
INSTALL_DIR=~/opt/node

echo "Instalando Node.js versión 20.13.1 "

wget https://unofficial-builds.nodejs.org/download/release/v20.13.1/node-v20.13.1-linux-x64-glibc-217.tar.gz

sudo tar zxf node-v20.13.1-linux-x64-glibc-217.tar.gz -C /opt

if [ -d "$INSTALL_DIR" ]; then
    sudo mv "$INSTALL_DIR" "$INSTALL_DIR.old"
fi

sudo mv /opt/node-v20.13.1-linux-x64-glibc-217 "$INSTALL_DIR"

export PATH=$INSTALL_DIR/bin:$PATH

node -v

if ! grep -q 'export PATH=/opt/node/bin:$PATH' /etc/profile; then
    echo 'export PATH=/opt/node/bin:$PATH' | sudo tee -a /etc/profile
    source /etc/profile
fi

echo "Node.js y npm instalados."