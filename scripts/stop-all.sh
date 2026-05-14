#!/bin/bash
# Navigate to the project root relative to this script
cd "$(dirname "$0")/.."


echo "--- Stopping Applications ---"
for dir in apps/*/ ; do
    if [ -d "$dir" ]; then
        echo "Stopping ${dir%/}..."
        cd "$dir" && docker compose down && cd ../../
    fi
done

echo "--- Stopping Core Proxy ---"
cd core-proxy && docker compose down && cd ..

echo "--- All services stopped ---"
