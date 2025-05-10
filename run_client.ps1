# Change to the 'client' directory
Set-Location -Path "client"

# Run with x25519 only
$env:_JAVA_OPTIONS = "-Djdk.tls.namedGroups=x25519"
bal run
Move-Item -Path "..\results\timings.csv" -Destination "..\results\timings_x25519.csv" -Force

# Run with hybrid mode: X25519MLKEM768 + x25519
$env:_JAVA_OPTIONS = "-Djdk.tls.namedGroups=X25519MLKEM768,x25519"
bal run
Move-Item -Path "..\results\timings.csv" -Destination "..\results\timings_hybrid.csv" -Force
