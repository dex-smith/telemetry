#!/bin/sh
set -e

apk add --no-cache openssl >/dev/null

cert_dir=/etc/nginx/certs
server_name="${SERVER_NAME:-localhost}"

mkdir -p "$cert_dir"

openssl req -x509 -nodes -newkey rsa:2048 -days 365 \
    -keyout "$cert_dir/privkey.pem" \
    -out "$cert_dir/fullchain.pem" \
    -subj "/CN=$server_name" \
    -addext "subjectAltName=DNS:$server_name,DNS:localhost,IP:127.0.0.1"

chmod 644 "$cert_dir/fullchain.pem" "$cert_dir/privkey.pem"
