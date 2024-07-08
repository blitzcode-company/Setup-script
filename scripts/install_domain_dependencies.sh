#!/bin/bash

echo "Instalando dependencias necesarias para unir al dominio..."
sudo dnf install -y realmd sssd adcli samba-common samba-common-tools oddjob oddjob-mkhomedir krb5-workstation openldap-clients
echo "Dependencias para unir al dominio instaladas."
