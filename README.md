# Geoinformatics KKU - Modular Infrastructure Manager

This repository uses a **Multi-Compose Architecture**. Each service (Proxy, Apps, etc.) is isolated in its own directory with its own `docker-compose.yml`.

## 📁 Project Structure
- **/core-proxy**: Central Nginx Reverse Proxy and Certbot SSL manager.
- **/apps**: Individual application directories (e.g., `gis-kku`).
- **/scripts**: Helper scripts for global management.

---

## 🖥️ Server Setup (Any Linux Server)

Follow these steps to prepare any fresh server for this infrastructure.

### 1. Install Prerequisites
Ensure Docker and Git are installed on your server:
```bash
# Ubuntu/Debian example
sudo apt update
sudo apt install -y docker.io docker-compose git
sudo systemctl enable --now docker

# Add your user to the docker group (to avoid permission denied)
sudo usermod -aG docker $USER
# IMPORTANT: Log out and log back in after this!
```

### 2. Clone the Repository
Clone the repository into your home directory (or any folder you have permission to write to):
```bash
git clone <your-repo-url> ~/gis_web_dockers
cd ~/gis_web_dockers
```

### 3. Configure Firewall
Ensure ports 80 (HTTP) and 443 (HTTPS) are open to the public:
```bash
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw reload
```

---

## 🚀 Quick Start (Deployment)

### 1. Initialize the Infrastructure
```bash
bash scripts/start-all.sh
```
*Note: This script creates the shared `gis_network` and starts all services in the correct order.*

### 2. Configure a New App
To host a new domain/app:
1. Create a new folder in `apps/` (e.g., `apps/my-new-site`).
2. Create a `docker-compose.yml` in that folder (use the `gis-kku` one as a template).
3. Add a new Nginx config in `core-proxy/nginx/conf.d/`.
4. Run `bash scripts/request_ssl.sh yourdomain.com`.

---

## 🛠️ Global Management

### Start All Services
```bash
bash scripts/start-all.sh
```

### Stop All Services
```bash
bash scripts/stop-all.sh
```

### View Logs for a Specific App
```bash
cd apps/gis-kku
docker compose logs -f
```

---

## 🔐 SSL Management (Let's Encrypt)

Certificates are managed centrally in the `core-proxy` container.

### Initial Request
```bash
bash scripts/request_ssl.sh geoinformatics.kku.ac.th
```

### Auto-Renewal
The `core-proxy` certbot service automatically renews all certificates every 12 hours.

---

## 💾 Data & Persistence

This project uses **Local Bind Mounts** (the `./data` folder) instead of named volumes.

### Why?
1.  **Isolation**: Since data is stored in `./apps/app-name/data/`, there is **zero risk** of two apps accidentally sharing the same volume.
2.  **Portability**: You can move an entire app folder to another server, and all its database and website files go with it.
3.  **Easy Backups**: You can simply `tar` or `zip` the `/apps/` directory to back up every website on the server.

---

## 🔍 Troubleshooting

### 1. Health Checks
Check if any service is unhealthy:
```bash
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
```

### 2. Network Issues
If apps cannot talk to each other, ensure they are both on the `gis_network`:
```bash
docker network inspect gis_network
```

### 3. Nginx Config Test
Before reloading, always test the config in the proxy:
```bash
docker compose -f core-proxy/docker-compose.yml exec nginx nginx -t
```

---
**Maintained by**: Geoinformatics KKU IT Team
**Last Updated**: 2026-05-10
