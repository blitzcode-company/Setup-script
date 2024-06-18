#!/bin/bash

function update_system {
    echo "Actualizando el sistema..."
    sudo yum update -y
    echo "Sistema actualizado."
}

function install_dependencies {
    echo "Instalando dependencias necesarias..."
    sudo yum install -y epel-release
    sudo yum install -y wget curl git unzip
    echo "Dependencias necesarias instaladas."
}

function install_php {
    echo "Instalando PHP..."
    sudo yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
    sudo yum-config-manager --enable remi-php82
    sudo yum install -y php php-cli php-fpm php-mysqlnd php-xml php-mbstring php-zip php-devel php-intl php-soap php-ldap
    echo "PHP instalado."
}

function install_composer {
    echo "Instalando Composer..."
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer
    php -r "unlink('composer-setup.php');"
    echo "Composer instalado."
}

function install_node_npm {
    echo "Instalando Node.js y npm..."
    curl -sL https://rpm.nodesource.com/setup_14.x | sudo bash -
    sudo yum install -y nodejs
    echo "Node.js y npm instalados."
}

function install_docker {
    echo "Instalando Docker..."
    sudo yum install -y yum-utils device-mapper-persistent-data lvm2
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install -y docker-ce
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -aG docker $(whoami)
    echo "Docker instalado."
}

function install_docker_compose {
    echo "Instalando Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    docker-compose --version
    echo "Docker Compose instalado."
}

function install_domain_dependencies {
    echo "Instalando dependencias necesarias para unir al dominio..."
    sudo yum install -y realmd sssd adcli samba-common samba-common-tools oddjob oddjob-mkhomedir krb5-workstation openldap-clients
    echo "Dependencias para unir al dominio instaladas."
}

function join_domain_blitzcode {
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
}

function install_node_exporter {
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
}
function install_node_exporter {
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
}

function configure_shorewall {
# Instalación de Shorewall
sudo yum install -y shorewall

# Configuración de zonas
cat <<EOF | sudo tee /etc/shorewall/zones
#ZONE    TYPE      OPTIONS
fw       firewall
lan      ipv4      
net      ipv4      
EOF

# Configuración de interfaces
cat <<EOF | sudo tee /etc/shorewall/interfaces
#ZONE    INTERFACE    BROADCAST    OPTIONS
lan      enp0s3       detect       dhcp
net      enp0s8       detect       dhcp
EOF

# Configuración de políticas
cat <<EOF | sudo tee /etc/shorewall/policy
#SOURCE    DEST      POLICY      LOG LEVEL    LIMIT
fw         all       ACCEPT
lan        all       REJECT      info
net        all       DROP        info
all        all       REJECT      info
EOF

# Configuración de reglas
cat <<EOF | sudo tee /etc/shorewall/rules
#ACTION    SOURCE          DEST        PROTO   DEST PORT     SOURCE PORT
ACCEPT     192.168.1.101   fw             tcp     22         # SSH desde back office
ACCEPT     192.168.1.101   192.168.1.105  tcp   3306         # MySQL DB1 desde back office
ACCEPT     192.168.1.101   192.168.1.106  tcp   3306         # MySQL DB2 (Replicación) desde back office
ACCEPT     192.168.1.101   192.168.1.100  tcp   3389         # Windows Server principal desde back office
ACCEPT     192.168.1.101   192.168.1.102  tcp   3389         # Windows Server réplica 1 desde back office
ACCEPT     192.168.1.101   192.168.1.103  tcp   3389         # Windows Server réplica 2 desde back office
ACCEPT     192.168.1.101   192.168.1.104  tcp   3389         # Windows Server solo lectura desde back office
ACCEPT     192.168.1.101   192.168.1.110  tcp   9090         # Prometheus desde back office
ACCEPT     192.168.1.101   192.168.1.108  tcp   80           # API OAuth y videos desde back office
ACCEPT     192.168.1.101   192.168.1.107  tcp   80           # Aplicación de backoffice desde back office
ACCEPT     192.168.1.101   192.168.1.112  tcp   25           # SMTP4dev desde back office
ACCEPT     192.168.1.101   192.168.1.111  tcp   80           # Servidor de videos desde back office

# Permitir conexiones PPTP hacia back office
ACCEPT     net             192.168.1.101   tcp     pptp

# Permitir acceso desde la LAN al firewall
ACCEPT     lan              fw            icmp    -            -             # Permitir ping al firewall
ACCEPT     lan              fw             tcp     22            -             # Permitir SSH al firewall
EOF

# Habilitar clampmss en Shorewall
sudo sed -i 's/^#?CLAMPMSS=.*$/CLAMPMSS=Yes/' /etc/shorewall/shorewall.conf

# Habilitar Shorewall en el inicio del sistema
sudo sed -i 's/STARTUP_ENABLED=.*/STARTUP_ENABLED=Yes/' /etc/shorewall/shorewall.conf

# Habilitar IP forwarding en sysctl.conf
sudo sed -i '/net.ipv4.ip_forward/s/^#//g' /etc/sysctl.conf

# Reiniciar configuración de sysctl
sudo sysctl -p /etc/sysctl.conf

# Habilitar IP forwarding en iptables
sudo iptables -P FORWARD ACCEPT

# Habilitar DETECT_DNAT_IPADDRS en Shorewall
sudo sed -i 's/^#?DETECT_DNAT_IPADDRS=.*$/DETECT_DNAT_IPADDRS=Yes/' /etc/shorewall/shorewall.conf

# Habilitar FASTACCEPT en Shorewall
sudo sed -i 's/^#?FASTACCEPT=.*$/FASTACCEPT=Yes/' /etc/shorewall/shorewall.conf

# Habilitar IP_FORWARDING en Shorewall
sudo sed -i 's/^#?IP_FORWARDING=.*$/IP_FORWARDING=On/' /etc/shorewall/shorewall.conf

# Habilitar y arrancar Shorewall
sudo systemctl enable shorewall
sudo systemctl start shorewall

# Mostrar estado de Shorewall
sudo shorewall status
}



# Menu principal
while true; do
    echo "Seleccione una opción:"
    echo "1. Actualizar el sistema"
    echo "2. Instalar dependencias necesarias"
    echo "3. Instalar PHP"
    echo "4. Instalar Composer"
    echo "5. Instalar Node.js y npm"
    echo "6. Instalar Docker"
    echo "7. Instalar Docker Compose"
    echo "8. Instalar dependencias para unir al dominio"
    echo "9. Unir al dominio Blitzcode"
    echo "10. Instalar Node Exporter"
    echo "11. Configurar Shorewall"
    echo "0. Salir"
    read -p "Opción: " option

    case $option in
        0) exit ;;
        1) update_system ;;
        2) install_dependencies ;;
        3) install_php ;;
        4) install_composer ;;
        5) install_node_npm ;;
        6) install_docker ;;
        7) install_docker_compose ;;
        8) install_domain_dependencies ;;
        9) join_domain_blitzcode ;;
        10) install_node_exporter ;;
        11) configure_shorewall ;;
        *) echo "Opción inválida. Inténtelo de nuevo." ;;
    esac
done
