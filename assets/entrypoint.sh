#!/bin/sh
# entrypoint.sh

set -e

mkdir -p /etc/nginx/certs

if [ ! -f /etc/nginx/certs/server.crt ]; then
    echo "Generating self-signed certificate..."

    apk add --no-cache openssl >/dev/null

    openssl req -x509 -nodes -newkey rsa:4096 \
        -keyout /etc/nginx/certs/server.key \
        -out /etc/nginx/certs/server.crt \
        -days 1 \
        -subj "/CN=null"
fi

echo "Executing nginx webserver..."

exec nginx -g "daemon off;"
