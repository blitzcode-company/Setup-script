#!/bin/bash

echo "Instalando Node Exporter..."
NODE_EXPORTER_VERSION="1.8.1"
cd /tmp
wget https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
tar xzf node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
sudo mv node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64/node_exporter /usr/local/bin/
rm -rf node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64*

echo "Creando usuario node_exporter..."
sudo useradd -rs /bin/false node_exporter

echo "Creando archivo de servicio systemd para Node Exporter..."
sudo bash -c 'cat <<EOF > /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=default.target
EOF'

echo "Recargando demonio systemd..."
sudo systemctl daemon-reload

echo "Habilitando y arrancando Node Exporter..."
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

echo "Node Exporter instalado y ejecutándose como servicio."