# Geoinformatics KKU - Modular Multi-Compose Infrastructure

This repository uses a **Modular Multi-Compose Architecture** to manage the Geoinformatics KKU server infrastructure (geoinformatics.kku.ac.th). 

## Project Scope
- **Core Proxy**: A central `core-proxy/` module handles Nginx and Certbot for the entire server.
- **Isolated Apps**: Each domain or application has its own directory in `apps/` with a dedicated `docker-compose.yml`.
- **Global Orchestration**: Start/stop scripts manage the lifecycle of all modules simultaneously.
- **Shared Networking**: All modules communicate via a global external bridge network named `gis_network`.

## Technical Stack
- **Web Server**: Nginx Alpine (Latest).
- **Application**: WordPress (PHP 8.3 FPM-Alpine).
- **Database**: MariaDB 11.4 (LTS).
- **Cache**: Redis (Latest Alpine).
- **Orchestration**: Docker Compose V2.
