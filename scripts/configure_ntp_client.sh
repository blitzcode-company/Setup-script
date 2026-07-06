#!/bin/bash

set -e

NTP_MASTER_IP="192.168.1.109"

echo "=== Configurando este nodo como cliente NTP ==="

if ! rpm -q chrony &>/dev/null; then
    echo "Instalando chrony..."
    sudo dnf install -y chrony
fi

echo "Modificando /etc/chrony.conf..."
sudo sed -i 's/^pool /#pool /g' /etc/chrony.conf
sudo sed -i 's/^server /#server /g' /etc/chrony.conf

if ! grep -q "server $NTP_MASTER_IP" /etc/chrony.conf; then
    echo "Auntando al servidor maestro $NTP_MASTER_IP..."
    # Insertar la configuración al principio del archivo
    echo -e "server $NTP_MASTER_IP iburst\n$(cat /etc/chrony.conf)" | sudo tee /etc/chrony.conf > /dev/null
fi

echo "Reiniciando servicios y forzando actualización de reloj..."
sudo systemctl enable chronyd
sudo systemctl restart chronyd
sudo chronyc -a makestep

echo "----------------------------------------"
chronyc sources
echo "----------------------------------------"
echo "¡Sincronización con el maestro $NTP_MASTER_IP completada con éxito!"
