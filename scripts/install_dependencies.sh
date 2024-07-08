#!/bin/bash

echo "Instalando dependencias necesarias..."
sudo dnf install -y epel-release
sudo dnf install -y wget curl git unzip
echo "Dependencias necesarias instaladas."
