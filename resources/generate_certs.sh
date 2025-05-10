#!/bin/bash

# Create resources directory if it doesn't exist
mkdir -p $(dirname "$0")

# Generate private key and self-signed certificate
openssl req -x509 -newkey rsa:4096 -keyout $(dirname "$0")/private.key -out $(dirname "$0")/public.crt -days 365 -nodes -subj "/CN=localhost" -addext "subjectAltName = DNS:localhost"

echo "Certificates generated successfully in $(dirname "$0")"
echo "To use X25519MLKEM768, ensure you have OpenSSL 3.2+ with post-quantum support"
