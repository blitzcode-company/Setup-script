#!/bin/bash

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
    echo "11. Clonar repositorios"
    echo "0. Salir"
    read -p "Opción: " option

    case $option in
        0) exit ;;
        1) ./scripts/update_system.sh ;;
        2) ./scripts/install_dependencies.sh ;;
        3) ./scripts/install_php.sh ;;
        4) ./scripts/install_composer.sh ;;
        5) ./scripts/install_node_npm.sh ;;
        6) ./scripts/install_docker.sh ;;
        7) ./scripts/install_docker_compose.sh ;;
        8) ./scripts/install_domain_dependencies.sh ;;
        9) ./scripts/join_domain_blitzcode.sh ;;
        10) ./scripts/install_node_exporter.sh ;;
        11) ./scripts/clone_repositories_menu.sh ;;
        *) echo "Opción inválida. Inténtelo de nuevo." ;;
    esac
done
