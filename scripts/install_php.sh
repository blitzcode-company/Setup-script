#!/bin/bash

echo "Instalando PHP..."

sudo dnf install -y http://rpms.remirepo.net/enterprise/remi-release-8.rpm
sudo dnf module enable -y php:remi-8.2
sudo dnf install -y php php-cli php-fpm php-mysqlnd php-xml php-mbstring php-zip php-devel php-intl php-soap php-ldap
echo "PHP instalado."
