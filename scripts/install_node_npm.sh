#!/bin/bash
INSTALL_DIR=~/opt/node

echo "Instalando Node.js versión 20.13.1 "

wget https://unofficial-builds.nodejs.org/download/release/v20.13.1/node-v20.13.1-linux-x64-glibc-217.tar.gz

tar zxf node-v20.13.1-linux-x64-glibc-217.tar.gz

if [ -d "$INSTALL_DIR" ]; then
    mv "$INSTALL_DIR" "$INSTALL_DIR.old"
fi

mkdir -p "$(dirname "$INSTALL_DIR")"
cp -r node-v20.13.1-linux-x64-glibc-217 "$INSTALL_DIR"

export PATH=$INSTALL_DIR/bin:$PATH

node -v

if ! grep -q 'export PATH=~/opt/node/bin:$PATH' ~/.bashrc; then
    echo 'export PATH=~/opt/node/bin:$PATH' >> ~/.bashrc
    source ~/.bashrc
fi
echo "Node.js y npm instalados."