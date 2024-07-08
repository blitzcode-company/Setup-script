#!/bin/bash

echo "Instalando Docker..."
sudo dnf install -y dnf-plugins-core device-mapper-persistent-data lvm2
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $(whoami)
echo "Docker instalado."
