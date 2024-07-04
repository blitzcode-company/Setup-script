#!/bin/bash

echo "Instalando PHP..."
sed -i 's/mirror.centos.org/vault.centos.org/g' /etc/yum.repos.d/*.repo
sed -i 's/^#.*baseurl=http/baseurl=http/g' /etc/yum.repos.d/*.repo
sed -i 's/^mirrorlist=http/#mirrorlist=http/g' /etc/yum.repos.d/*.repo

sudo yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum-config-manager --enable remi-php82
sudo yum install -y php php-cli php-fpm php-mysqlnd php-xml php-mbstring php-zip php-devel php-intl php-soap php-ldap
echo "PHP instalado."