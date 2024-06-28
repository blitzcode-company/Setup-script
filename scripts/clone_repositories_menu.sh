#!/bin/bash

current_dir=$(pwd)
cd "$(dirname "$0")/../../"

clone_and_move_docker() {
    git clone https://github.com/blitzcode-company/Docker.git &&
    mv Docker/* . &&
    sudo rm -r Docker
}

clone_and_setup_blitzvideo_api() {
    git clone https://github.com/blitzcode-company/Blitzvideo-api.git &&
    cd Blitzvideo-api &&
    read -p "¿Quieres ejecutar 'composer install' y 'cp .env.example .env'? (y/n): " install_option
    if [[ "$install_option" == "y" || "$install_option" == "Y" ]]; then
        composer install
        cp .env.example .env
        php artisan key:generate
    fi
    cd ..
}

clone_and_setup_oauth_api() {
    git clone https://github.com/blitzcode-company/Oauth-api.git &&
    cd Oauth-api &&
    read -p "¿Quieres ejecutar 'composer install' y 'cp .env.example .env'? (y/n): " install_option
    if [[ "$install_option" == "y" || "$install_option" == "Y" ]]; then
        composer install
        cp .env.example .env
        php artisan key:generate
    fi
    cd ..
}

clone_and_setup_blitzvideo_auth() {
    git clone https://github.com/blitzcode-company/Blitzvideo-Auth.git &&
    cd Blitzvideo-Auth &&
    read -p "¿Quieres ejecutar 'npm install'?' (y/n): " install_option
    if [[ "$install_option" == "y" || "$install_option" == "Y" ]]; then
        npm install
    fi
    cd ..
}

clone_and_setup_backoffice() {
    git clone https://github.com/blitzcode-company/Backoffice.git &&
    cd Backoffice &&
    read -p "¿Quieres ejecutar 'composer install' y 'cp .env.example .env'? (y/n): " install_option
    if [[ "$install_option" == "y" || "$install_option" == "Y" ]]; then
        composer install
        cp .env.example .env
        php artisan key:generate
    fi
    cd ..
}

clone_and_setup_blitzvideo_visualizer() {
    git clone https://github.com/blitzcode-company/Blitzvideo-Visualizer.git &&
    cd Blitzvideo-Visualizer &&
    read -p "¿Quieres ejecutar 'npm install'?' (y/n): " install_option
    if [[ "$install_option" == "y" || "$install_option" == "Y" ]]; then
        npm install
    fi
    cd ..
}

clone_and_setup_blitzvideo_creadores() {
    git clone https://github.com/blitzcode-company/Blitzvideo-Creadores.git &&
    cd Blitzvideo-Creadores &&
    read -p "¿Quieres ejecutar 'npm install'?' (y/n): " install_option
    if [[ "$install_option" == "y" || "$install_option" == "Y" ]]; then
        npm install
    fi
    cd ..
}

while true; do
    echo "Seleccione un repositorio para clonar:"
    echo "1. Blitzvideo-api (Backend)"
    echo "2. Oauth-api (Backend)"
    echo "3. Blitzvideo-Auth (Frontend)"
    echo "4. Blitzvideo-Visualizer (Frontend)"
    echo "5. Blitzvideo-Creadores (Frontend)"
    echo "6. Backoffice"
    echo "7. Mysql-master (Base de Datos)"
    echo "8. Mysql-slave (Base de Datos)"
    echo "9. Monitoreo (Monitoreo)"
    echo "10. Docker (Dockerfiles y docker-compose)"
    echo "0. Volver al menú principal"
    read -p "Opción: " repo_option

    case $repo_option in
        0) break ;;
        1) clone_and_setup_blitzvideo_api ;;
        2) clone_and_setup_oauth_api ;;
        3) clone_and_setup_blitzvideo_auth ;;
        4) clone_and_setup_blitzvideo_visualizer ;;
        5) clone_and_setup_blitzvideo_creadores ;;
        6) clone_and_setup_backoffice ;;
        7) git clone https://github.com/blitzcode-company/Mysql-master.git ;;
        8) git clone https://github.com/blitzcode-company/Mysql-slave.git ;;
        9) git clone https://github.com/blitzcode-company/Monitoreo.git ;;
        10) clone_and_move_docker ;;
        *) echo "Opción inválida. Inténtelo de nuevo." ;;
    esac
done

cd "$current_dir"
