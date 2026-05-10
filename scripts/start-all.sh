#!/bin/bash

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
