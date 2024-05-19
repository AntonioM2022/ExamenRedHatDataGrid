# ExamenRedHatDataGrid

Repositorio para el examen de administración de base de datos unidad 5

## Integrantes

- [Rocio Gardea](https://github.com/vanegardea)
- [Antonio Martínez](https://github.com/AntonioM2022)
- [Javier Prieto](https://github.com/JavierPrieto12)
- [Carlos Ramos](https://github.com/CarlosIRamosV)
- [Diego Vargas](https://github.com/DiegoAVargasE)

## Tecnologías

- Base de datos: MySQL
- Backend: Rust
- Frontend: Astro
- Contenedores: Docker
- Orquestador: Docker Compose
- Balanceador de carga: Nginx

## Ejecución de la aplicación

### Prerequisitos

- Tener instalado Docker
- Tener instalado Docker Compose
- Tener instalado Git

### Clonar el repositorio

```bash
git clone git@github.com:AntonioM2022/ExamenRedHatDataGrid.git && cd ExamenRedHatDataGrid
```

### Ejecutar la aplicación

```bash
docker-compose up
```

### Detener la aplicación

```bash
docker-compose down
```

### Verificar la ejecución

```bash
curl http://localhost:8080
```