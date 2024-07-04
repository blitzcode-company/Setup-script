#!/bin/bash
INSTALL_DIR=~/opt/node

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

INSTALL_DIR=/opt/node

echo "Instalando Node.js versión 20.13.1 en $INSTALL_DIR"

wget https://unofficial-builds.nodejs.org/download/release/v20.13.1/node-v20.13.1-linux-x64-glibc-217.tar.gz -P "$SCRIPT_DIR"

sudo tar zxf "$SCRIPT_DIR/node-v20.13.1-linux-x64-glibc-217.tar.gz" -C /opt

if [ -d "$INSTALL_DIR" ]; then
    sudo mv "$INSTALL_DIR" "$INSTALL_DIR.old"
fi

sudo mv "/opt/node-v20.13.1-linux-x64-glibc-217" "$INSTALL_DIR"

export PATH=$INSTALL_DIR/bin:$PATH

node -v

if ! sudo grep -q 'export PATH=/opt/node/bin:$PATH' /etc/profile; then
    echo 'export PATH=/opt/node/bin:$PATH' | sudo tee -a /etc/profile
    source /etc/profile
fi

echo "Node.js y npm instalados."