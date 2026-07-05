#!/bin/bash

set -e

DOMAIN="Blitzcode.company"
DC_IP="192.168.1.100"

echo "=== 1. Optimizando configuración de Red y DNS ==="

echo "Ajustando enp0s3 (Internet - NAT)..."

sudo nmcli connection modify enp0s3 ipv4.dns "$DC_IP, 8.8.8.8"
sudo nmcli connection modify enp0s3 ipv4.dns-search "$DOMAIN"
sudo nmcli connection up enp0s3

echo "Ajustando enp0s8 (Red Interna - Servidores)..."

sudo nmcli connection modify enp0s8 ipv4.dns "$DC_IP"
sudo nmcli connection modify enp0s8 ipv4.dns-search "$DOMAIN"
sudo nmcli connection up enp0s8

echo "=== 2. Forzando resolución local de IP para el Dominio ==="
sudo sed -i "/$DOMAIN/d" /etc/hosts || true
echo "$DC_IP $DOMAIN" | sudo tee -a /etc/hosts

echo "Esperando 3 segundos a que la red estabilice..."
sleep 3

echo "=== 3. Limpiando residuos de intentos anteriores ==="
sudo realm leave || true
sudo systemctl stop sssd || true

echo "=== 4. Descubriendo el dominio ==="
sudo realm discover $DOMAIN

echo "=== 5. Uniéndose al dominio ==="
read -p "Ingrese el nombre de usuario del administrador del dominio: " admin_user
sudo realm join --user=$admin_user $DOMAIN

echo "=== 6. Ajustando permisos de sssd.conf ==="
sudo chmod 600 /etc/sssd/sssd.conf

echo "=== 7. Habilitando servicios requeridos ==="
sudo systemctl enable sssd oddjobd
sudo systemctl start sssd oddjobd

echo "=== 8. Configurando creación automática de Homes (authselect) ==="
sudo authselect enable-feature with-mkhomedir
sudo systemctl restart oddjobd

echo "=== 9. Reiniciando sssd ==="
sudo systemctl restart sssd

echo "=== 10. Verificando configuración de dominio ==="
echo "----------------------------------------"
realm list
echo "----------------------------------------"
echo "¡Unión al dominio $DOMAIN completada con éxito!"
