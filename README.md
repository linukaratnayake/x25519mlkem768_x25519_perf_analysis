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

## Performance Testing

The client can be used to run performance tests on different TLS key exchange methods. The results are saved as CSV files for analysis.

### Running Performance Tests

1. Configure the number of requests and batch size:
   ```
   # Edit client/Config.toml to set required values
   requestCount = 1000000   # Total number of requests to make
   batchSize = 2000         # Number of requests per batch
   ```

2. Test Classical Elliptic Curve (x25519):
   ```bash
   # Set named group to x25519
   export _JAVA_OPTIONS="-Djdk.tls.namedGroups=x25519"
   
   # Run the client
   cd client
   bal run
   
   # Move the results to a specific file
   mv ../results/timings.csv ../results/timings_x25519.csv
   ```

3. Test Hybrid Post-Quantum (X25519MLKEM768):
   ```bash
   # Set named group to X25519MLKEM768
   export _JAVA_OPTIONS="-Djdk.tls.namedGroups=X25519MLKEM768"
   
   # Run the client
   cd client
   bal run
   
   # Move the results to a specific file
   mv ../results/timings.csv ../results/timings_hybrid.csv
   ```

4. Analyze the results:
   ```bash
   # Use the Jupyter notebook to visualize results
   cd ../results
   jupyter notebook visualize_results.ipynb
   ```

### Batch Processing

For large numbers of requests (e.g., 1 million), the client processes requests in batches to avoid memory issues. Progress is shown per batch, and results are incrementally written to the CSV file.

### Other Named Groups

Other possible named groups include:
- P256KYBER512
- P384KYBER768
- X25519KYBER768

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

### Testing with OpenSSL

Test the server with OpenSSL (if supported):
```
openssl s_client -connect localhost:9090 -curves X25519MLKEM768
```
