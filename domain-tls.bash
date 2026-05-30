#!/usr/bin/env bash

if [[ $# -lt 3 ]]
then
    echo "Usage: $0 cloudflare-secret.ini certificate-name domain1.com domain2.com ...."
    exit 1
fi

if ! [[ -f $1 ]]
then
    echo "Error: $1 not found or is corrupted"
    exit 1
fi

EMAIL="update this"
CLOUDFLARE_SECRET=$1
CERTIFICATE_NAME=$2
shift 2

certbot_args=()

for domain in "$@"; do
    certbot_args+=("-d" "$domain")
done

certbot certonly \
        --dns-cloudflare \
        --dns-cloudflare-credentials $CLOUDFLARE_SECRET \
        --cert-name $CERTIFICATE_NAME \
        --config-dir $HOME/.local/containers/letsencrypt \
        --work-dir $HOME/.local/containers/letsencrypt/work \
        --logs-dir $HOME/.local/containers/letsencrypt/logs \
        "${certbot_args[@]}" \
        -m $EMAIL \
        --agree-tos \
        --no-eff-email
