#!/bin/bash

set -e

DOMAIN="Blitzcode.company"
DC_IP="192.168.1.100"

echo "=== 1. Optimizando configuración de Red y DNS ==="

echo "Ajustando enp0s3..."
sudo nmcli connection modify enp0s3 ipv4.ignore-auto-dns yes
sudo nmcli connection modify enp0s3 ipv4.dns "$DC_IP"
sudo nmcli connection modify enp0s3 ipv4.dns-search "$DOMAIN"
sudo nmcli connection up enp0s3

echo "Ajustando enp0s8..."
sudo nmcli connection modify enp0s8 ipv4.dns "$DC_IP"
sudo nmcli connection modify enp0s8 ipv4.dns-search "$DOMAIN"
sudo nmcli connection up enp0s8

echo "Esperando 3 segundos a que la red estabilice..."
sleep 3

echo "=== 2. Limpiando residuos de intentos anteriores ==="
sudo realm leave || true
sudo systemctl stop sssd || true

echo "=== 3. Descubriendo el dominio ==="
sudo realm discover $DOMAIN

echo "=== 4. Uniéndose al dominio ==="
read -p "Ingrese el nombre de usuario del administrador del dominio: " admin_user
sudo realm join --user=$admin_user $DOMAIN

echo "=== 5. Ajustando permisos de sssd.conf ==="
sudo chmod 600 /etc/sssd/sssd.conf

echo "=== 6. Habilitando servicios requeridos ==="
sudo systemctl enable sssd oddjobd
sudo systemctl start sssd oddjobd

echo "=== 7. Configurando creación automática de Homes (authselect) ==="

sudo authselect enable-feature with-mkhomedir
sudo systemctl restart oddjobd

echo "=== 8. Reiniciando sssd ==="
sudo systemctl restart sssd

echo "=== 9. Verificando configuración de dominio ==="
echo "----------------------------------------"
realm list
echo "----------------------------------------"
echo "¡Unión al dominio $DOMAIN completada con éxito!"
