#!/bin/bash

# Check if domain is provided
if [ -z "$1" ]; then
    echo "Usage: $0 domain.com"
    exit 1
fi

DOMAIN=$1
EMAIL="admin@kku.ac.th" # You can change this or make it a variable

echo "--- Requesting SSL Certificate for $DOMAIN ---"

docker compose run --rm certbot certonly \
    --webroot --webroot-path /var/www/certbot/ \
    -d "$DOMAIN" \
    --email "$EMAIL" \
    --agree-tos \
    --no-eff-email

echo "--- Reloading Nginx to apply changes ---"
docker compose exec nginx nginx -s reload

echo "--- Success! SSL is now active for $DOMAIN ---"
