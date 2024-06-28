#!/bin/bash

echo "Uniendo al dominio Blitzcode..."
    
echo "Descubriendo el dominio..."
sudo realm discover Blitzcode.company
    
echo "Uniéndose al dominio..."
read -p "Ingrese el nombre de usuario del administrador del dominio: " admin_user
sudo realm join --user=$admin_user Blitzcode.company
    
echo "Ajustando permisos del archivo de configuración de sssd..."
sudo chmod 600 /etc/sssd/sssd.conf
    
echo "Habilitando y arrancando sssd..."
sudo systemctl enable sssd
sudo systemctl start sssd
    
echo "Habilitando y arrancando oddjobd..."
sudo systemctl enable oddjobd
sudo systemctl start oddjobd
    
echo "Configurando pam_mkhomedir..."
sudo bash -c 'echo "session    required     pam_mkhomedir.so skel=/etc/skel/ umask=0077" >> /etc/pam.d/common-session'
    
echo "Reiniciando sssd..."
sudo systemctl restart sssd
    
echo "Verificando configuración de dominio..."
realm list
echo "Unión al dominio Blitzcode completada."