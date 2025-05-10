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

This implementation supports TLS 1.3 with X25519MLKEM768 hybrid named group. You need:

1. OpenSSL 3.2+ with post-quantum support
2. Ballerina 2201.12.2 or newer with proper TLS implementation

### Changing the Named Group

The named group can be changed by editing the `Config.toml` file:

```toml
# Change to any supported named group
namedGroup = "X25519MLKEM768" 
```

Other possible named groups include:
- P256KYBER512
- P384KYBER768
- X25519KYBER768

### Testing with OpenSSL

Test the server with OpenSSL (if supported):
```
openssl s_client -connect localhost:9090 -curves X25519MLKEM768
```
