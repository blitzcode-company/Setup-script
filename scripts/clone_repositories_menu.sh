#!/bin/bash

BLITZVIDEO_API_REPO="https://github.com/blitzcode-company/Blitzvideo-api.git"
OAUTH_API_REPO="https://github.com/blitzcode-company/Oauth-api.git"
BLITZVIDEO_AUTH_REPO="https://github.com/blitzcode-company/Blitzvideo-Auth.git"
BLITZVIDEO_VISUALIZER_REPO="https://github.com/blitzcode-company/Blitzvideo-Visualizer.git"
BLITZVIDEO_CREADORES_REPO="https://github.com/blitzcode-company/Blitzvideo-Creadores.git"
BACKOFFICE_REPO="https://github.com/blitzcode-company/Backoffice.git"
API_PAGOS_REPO="https://github.com/blitzcode-company/api-pagos.git"
MYSQL_MASTER_REPO="https://github.com/blitzcode-company/Mysql-master.git"
MYSQL_SLAVE_REPO="https://github.com/blitzcode-company/Mysql-slave.git"
MONITOREO_REPO="https://github.com/blitzcode-company/Monitoreo.git"
MODERADORES_REPO="https://github.com/blitzcode-company/Blitzvideo-ApiModeradores.git"
DOCKER_REPO="https://github.com/blitzcode-company/Docker.git"
MODERADORES_VISUALIZER_REPO="https://github.com/blitzcode-company/Blitzvideo-ModeradoresVisualizer.git"

BLITZVIDEO_API_DIR="Blitzvideo-api"
MODERADORES_API_DIR="Blitzvideo-ApiModeradores"
MODERADORES_VISUALIZER_DIR="Blitzvideo-ModeradoresVisualizer"
OAUTH_API_DIR="Oauth-api"
BLITZVIDEO_AUTH_DIR="Blitzvideo-Auth"
BLITZVIDEO_VISUALIZER_DIR="Blitzvideo-Visualizer"
BLITZVIDEO_CREADORES_DIR="Blitzvideo-Creadores"
BACKOFFICE_DIR="Backoffice"
API_PAGOS_DIR="api-pagos"
DOCKER_DIR="Docker"

current_dir=$(pwd)
cd "$(dirname "$0")/../../"

clone_and_move_docker() {
    if [ ! -d "$DOCKER_DIR" ]; then
        git clone $DOCKER_REPO &&
        mv $DOCKER_DIR/* . &&
        sudo rm -r $DOCKER_DIR
    else
        echo "------------------------------------"
        echo "El repositorio ya ha sido clonado."
        echo "------------------------------------"
    fi
}

clone_and_setup_blitzvideo_api() {
    if [ ! -d "$BLITZVIDEO_API_DIR" ]; then
        git clone $BLITZVIDEO_API_REPO &&
        cd $BLITZVIDEO_API_DIR &&
        read -p "¿Quieres ejecutar 'composer install' y 'cp .env.example .env'? (y/n): " install_option
        if [[ "$install_option" == "y" || "$install_option" == "Y" ]]; then
            composer install
            cp .env.example .env
            php artisan key:generate
        fi
        cd ..
    else
        echo "------------------------------------"
        echo "El repositorio ya ha sido clonado."
        echo "------------------------------------"
    fi
}
clone_and_setup_blitzvideo_api_moderadores() {
    if [ ! -d "$MODERADORES_API_DIR" ]; then
        git clone $MODERADORES_REPO &&
        cd $MODERADORES_API_DIR &&
        read -p "¿Quieres ejecutar 'composer install' y 'cp .env.example .env'? (y/n): " install_option
        if [[ "$install_option" == "y" || "$install_option" == "Y" ]]; then
            composer install
            cp .env.example .env
            php artisan key:generate
        fi
        cd ..
    else
        echo "------------------------------------"
        echo "El repositorio ya ha sido clonado."
        echo "------------------------------------"
    fi
}

clone_and_setup_oauth_api() {
    if [ ! -d "$OAUTH_API_DIR" ]; then
        git clone $OAUTH_API_REPO &&
        cd $OAUTH_API_DIR &&
        read -p "¿Quieres ejecutar 'composer install' y 'cp .env.example .env'? (y/n): " install_option
        if [[ "$install_option" == "y" || "$install_option" == "Y" ]]; then
            composer install
            cp .env.example .env
            php artisan key:generate
            php artisan passport:keys
        fi
        cd ..
    else
        echo "------------------------------------"
        echo "El repositorio ya ha sido clonado."
        echo "------------------------------------"
    fi
}

clone_and_setup_blitzvideo_auth() {
    if [ ! -d "$BLITZVIDEO_AUTH_DIR" ]; then
        git clone $BLITZVIDEO_AUTH_REPO &&
        cd $BLITZVIDEO_AUTH_DIR &&
        read -p "¿Quieres ejecutar 'npm install'?' (y/n): " install_option
        if [[ "$install_option" == "y" || "$install_option" == "Y" ]]; then
            npm install
        fi
        cd ..
    else
        echo "------------------------------------"
        echo "El repositorio ya ha sido clonado."
        echo "------------------------------------"
    fi
}

clone_and_setup_backoffice() {
    if [ ! -d "$BACKOFFICE_DIR" ]; then
        git clone $BACKOFFICE_REPO &&
        cd $BACKOFFICE_DIR &&
        read -p "¿Quieres ejecutar 'composer install' y 'cp .env.example .env'? (y/n): " install_option
        if [[ "$install_option" == "y" || "$install_option" == "Y" ]]; then
            composer install
            cp .env.example .env
            php artisan key:generate
        fi
        cd ..
    else
        echo "------------------------------------"
        echo "El repositorio ya ha sido clonado."
        echo "------------------------------------"
    fi
}

clone_and_setup_api_pagos() {
    if [ ! -d "$API_PAGOS_DIR" ]; then
        git clone $API_PAGOS_REPO &&
        cd $API_PAGOS_DIR &&
        read -p "¿Quieres ejecutar 'composer install' y 'cp .env.example .env'? (y/n): " install_option
        if [[ "$install_option" == "y" || "$install_option" == "Y" ]]; then
            composer install
            cp .env.example .env
            php artisan key:generate
        fi
        cd ..
    else
        echo "------------------------------------"
        echo "El repositorio ya ha sido clonado."
        echo "------------------------------------"
    fi
}

clone_and_setup_blitzvideo_visualizer() {
    if [ ! -d "$BLITZVIDEO_VISUALIZER_DIR" ]; then
        git clone $BLITZVIDEO_VISUALIZER_REPO &&
        cd $BLITZVIDEO_VISUALIZER_DIR &&
        read -p "¿Quieres ejecutar 'npm install'?' (y/n): " install_option
        if [[ "$install_option" == "y" || "$install_option" == "Y" ]]; then
            npm install
        fi
        cd ..
    else
        echo "------------------------------------"
        echo "El repositorio ya ha sido clonado."
        echo "------------------------------------"
    fi
}

clone_and_setup_blitzvideo_moderadores_visualizer() {
    if [ ! -d "$MODERADORES_VISUALIZER_DIR" ]; then
        git clone $MODERADORES_VISUALIZER_REPO &&
        cd $MODERADORES_VISUALIZER_DIR &&
        read -p "¿Quieres ejecutar 'npm install'?' (y/n): " install_option
        if [[ "$install_option" == "y" || "$install_option" == "Y" ]]; then
            npm install
        fi
        cd ..
    else
        echo "------------------------------------"
        echo "El repositorio ya ha sido clonado."
        echo "------------------------------------"
    fi
}

clone_and_setup_blitzvideo_creadores() {
    if [ ! -d "$BLITZVIDEO_CREADORES_DIR" ]; then
        git clone $BLITZVIDEO_CREADORES_REPO &&
        cd $BLITZVIDEO_CREADORES_DIR &&
        read -p "¿Quieres ejecutar 'npm install'?' (y/n): " install_option
        if [[ "$install_option" == "y" || "$install_option" == "Y" ]]; then
            npm install
        fi
        cd ..
    else
        echo "------------------------------------"
        echo "El repositorio ya ha sido clonado."
        echo "------------------------------------"
    fi
}

while true; do
    echo "Seleccione un repositorio para clonar:"
    echo "1. Blitzvideo-api (Backend)"
    echo "2. Oauth-api (Backend)"
    echo "3. Moderadores-api (Backend)"
    echo "4. Blitzvideo-Auth (Frontend)"
    echo "5. Blitzvideo-Visualizer (Frontend)"
    echo "6. Blitzvideo-Creadores (Frontend)"
    echo "7. Blitzvideo-Moderadores (Frontend)"
    echo "8. Backoffice"
    echo "9. Api-pagos (Backend)"
    echo "10. Mysql-master (Base de Datos)"
    echo "11. Mysql-slave (Base de Datos)"
    echo "12. Monitoreo (Monitoreo)"
    echo "13. Docker (Dockerfiles y docker-compose)"
    echo "0. Volver al menú principal"
    read -p "Opción: " repo_option

    case $repo_option in
        0) break ;;
        1) clone_and_setup_blitzvideo_api ;;
        2) clone_and_setup_oauth_api ;;
        3) clone_and_setup_blitzvideo_api_moderadores;;
        4) clone_and_setup_blitzvideo_auth ;;
        5) clone_and_setup_blitzvideo_visualizer ;;
        6) clone_and_setup_blitzvideo_creadores ;;
        7) clone_and_setup_blitzvideo_moderadores_visualizer ;;
        8) clone_and_setup_backoffice ;;
        9) clone_and_setup_api_pagos ;;
        10) git clone $MYSQL_MASTER_REPO ;;
        11) git clone $MYSQL_SLAVE_REPO ;;
        12) git clone $MONITOREO_REPO ;;
        13) clone_and_move_docker ;;
        *) echo "Opción inválida. Inténtelo de nuevo." ;;
    esac
done

cd "$current_dir"
