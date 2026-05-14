#!/bin/bash
# Navigate to the project root relative to this script
cd "$(dirname "$0")/.."


# Check for Docker permission
if ! docker info >/dev/null 2>&1; then
    echo "Error: Cannot connect to Docker daemon. Try running with 'sudo' or add your user to the 'docker' group."
    exit 1
fi

# Ensure external network exists
docker network create gis_network 2>/dev/null || true

echo "--- Starting Core Proxy ---"
cd core-proxy && docker compose up -d && cd ..

echo "--- Starting Applications ---"
for dir in apps/*/ ; do
    if [ -d "$dir" ]; then
        echo "Starting ${dir%/}..."
        cd "$dir" && docker compose up -d && cd ../../
    fi
done

echo "--- All services started ---"
