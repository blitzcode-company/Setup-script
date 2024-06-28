#!/bin/bash

current_dir=$(pwd)
cd "$(dirname "$0")/../../"

clone_and_move_docker() {
    git clone https://github.com/blitzcode-company/Docker.git &&
    mv Docker/* . &&
    rm -r Docker
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
        1) git clone https://github.com/blitzcode-company/Blitzvideo-api.git ;;
        2) git clone https://github.com/blitzcode-company/Oauth-api.git ;;
        3) git clone https://github.com/blitzcode-company/Blitzvideo-Auth.git ;;
        4) git clone https://github.com/blitzcode-company/Blitzvideo-Visualizer.git ;;
        5) git clone https://github.com/blitzcode-company/Blitzvideo-Creadores.git ;;
        6) git clone https://github.com/blitzcode-company/Backoffice.git ;;
        7) git clone https://github.com/blitzcode-company/Mysql-master.git ;;
        8) git clone https://github.com/blitzcode-company/Mysql-slave.git ;;
        9) git clone https://github.com/blitzcode-company/Monitoreo.git ;;
        10) clone_and_move_docker ;;
        *) echo "Opción inválida. Inténtelo de nuevo." ;;
    esac
done

cd "$current_dir"
