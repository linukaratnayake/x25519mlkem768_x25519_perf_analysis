# Performance Analysis and Comparison between X25519MLKEM768 and X25519 Algorithms

A simple HTTPS server is written in Ballerina, and tested against a simple client also written in Ballerina. The client generates the early key shares in the following two scenarios and tested against the server.

1. Both `X25519MLKEM768` and `X25519`.
2. Only `X25519`.

The results are saved in CSV format any analyzed using Python.

> ### Please note that most of the code is generated using AI, and hence can contain bugs and/ or issues with logic.

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
   bal run
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

   > By default, outliers will be removed from datapoints. To turn off this setting, change Cell 4.

   ```python
   # Configuration parameter for outlier removal
   # Set to True to remove outliers in the data, False to keep all data points
   remove_outliers = True
   ```

## Versions and Configurations

The following are the software versions installed.

1. Ballerina Swan Lake Update 12

The specifications of the host computers are as follows.

- Apple MacBook Air M1 16GB RAM - 2000 iterations
- PC with Intel Core i7 10th Gen 1.30 GHz, 16GB RAM (Windows 11) - 15000 iterations
- PC with Intel Core i7 10th Gen 1.80 GHz, 16GB RAM (Ubuntu 22.04) - 1000 iterations
