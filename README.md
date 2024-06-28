# CentOS DevOps Setup Script

<p align="center">
    <img src="https://drive.google.com/uc?export=download&id=1yyVoEHmLQgzYpDJJJvjtpo1MHdZNP84k" width="200">
</p>

Este script automatiza la configuración inicial de un entorno de desarrollo en CentOS, instalando diversas herramientas y configurando la integración con un dominio Blitzcode.

### Descarga del script
```bash
git clone https://github.com/blitzcode-company/setup-script.git
```

### Ejecución del script

```bash
cd setup-script
sudo chmod +x setup.sh
sudo ./setup.sh
```

Opciones disponibles

## El script presenta un menú interactivo con las siguientes opciones:

  1. Actualizar el sistema: Actualiza el sistema operativo CentOS.
  2. Instalar dependencias necesarias: Instala herramientas básicas como wget, curl, etc.
  3. Instalar PHP: Instala PHP versión 8.2 y sus extensiones necesarias.
  4. Instalar Composer: Instala Composer para la gestión de paquetes de PHP.
  5. Instalar Node.js y npm: Instala Node.js versión 14.x y npm.
  6. Instalar Docker: Instala Docker y configura el entorno Docker.
  7. Instalar Docker Compose: Descarga y configura Docker Compose.
  8. Instalar dependencias para unir al dominio: Instala paquetes necesarios para unirse a un dominio.
  9. Unir al dominio Blitzcode: Guía para unirse al dominio Blitzcode y configurar SSSD.
  10. Instalar Node Exporter: Descarga, instala y configura Node Exporter para que se ejecute como un servicio.
  11. Clonar repositorios: Muestra un submenú para clonar diversos repositorios del proyecto Blitzcode
    - Blitzvideo-api
    - Oauth-api
    - Blitzvideo-Auth
    - Blitzvideo-Visualizer
    - Blitzvideo-Creadores
    - Backoffice
    - Mysql-master
    - Mysql-slave
    - Monitoreo
    - Docker 
  0. Termina la ejecución del script.

**Nota:** 
Para clonar los repositorios, selecciona la opción 11 y luego elige el repositorio que deseas clonar del submenú, se clonan un nivel fuera del repositorio de setup-script. 
Para el repositorio Docker, los archivos se moverán a la raíz del proyecto y se eliminará la carpeta clonada.