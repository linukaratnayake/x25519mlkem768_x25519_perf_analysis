# X25519MLKEM768 Performance Test Server

A simple HTTPS server in Ballerina for testing with X25519MLKEM768 hybrid key exchange.

## Setup Instructions

1. Generate SSL certificates:
   ```
   cd resources
   chmod +x generate_certs.sh
   ./generate_certs.sh
   ```

2. Run the server:
   ```
   cd server
   bal run main.bal
   ```

3. Access the endpoint:
   ```
   curl -k https://localhost:9090/greeting
   ```

## X25519MLKEM768 Configuration

To properly enable X25519MLKEM768 named group for TLS, you'll need:

1. OpenSSL 3.2+ with post-quantum support
2. Configure your environment to support this named group
3. You might need to modify the Ballerina runtime's SSL configuration or use custom providers

Example OpenSSL configuration (if supported):
```
openssl s_client -connect localhost:9090 -curves X25519MLKEM768
```

Note: Full support for X25519MLKEM768 depends on your Ballerina version and underlying TLS implementation.
