# Define the current script's directory
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Create directory if it doesn't exist
if (-not (Test-Path -Path $scriptDir)) {
    New-Item -ItemType Directory -Path $scriptDir | Out-Null
}

# Define paths for key and certificate
$privateKeyPath = Join-Path $scriptDir "private.key"
$publicCertPath = Join-Path $scriptDir "public.crt"

# Generate private key and self-signed certificate using OpenSSL
openssl req -x509 -newkey rsa:4096 `
    -keyout $privateKeyPath `
    -out $publicCertPath `
    -days 365 -nodes `
    -subj "/CN=localhost" `
    -addext "subjectAltName = DNS:localhost"

Write-Host "Certificates generated successfully in $scriptDir"
Write-Host "To use X25519MLKEM768, ensure you have OpenSSL 3.2+ with post-quantum support"
