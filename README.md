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
   # Edit Config.toml file
   requestCount = 2000
   ```
> The host computer gave a memory error when values above 2000 are used.

2. Test Classical Elliptic Curve Algorithm (x25519):
   ```bash
   # Set named group to x25519
   export _JAVA_OPTIONS="-Djdk.tls.namedGroups=x25519"
   
   # Run the client
   cd client
   bal run
   
   # Move the results to a specific file
   mv ../results/timings.csv ../results/timings_x25519.csv
   ```

3. Test Hybrid Post-Quantum Algorithm (X25519MLKEM768):
   ```bash
   # Set named group to X25519MLKEM768
   export _JAVA_OPTIONS="-Djdk.tls.namedGroups=X25519MLKEM768"
   
   # Run the client
   cd client
   bal run
   
   # Move the results to a specific file
   mv ../results/timings.csv ../results/timings_hybrid.csv
   ```

> Alternatively, instead of above steps 2 and 3, you can run the `run_client.sh` file.

4. Analyze the results:
   ```bash
   # Use the Jupyter notebook to visualize results
   cd ../results
   jupyter-notebook visualize_results.ipynb
   ```

## Versions and Configurations

The following are the software versions installed.

1. Ballerina Swan Lake Update 12 (2201.12.2)
2. OpenSSL 3.4.1 11 Feb 2025

The specification of the host computer is as follows.

- MacBook Air M1 16GB RAM
