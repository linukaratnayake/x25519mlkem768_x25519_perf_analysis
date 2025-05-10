import ballerina/http;
import ballerina/io;
import ballerina/time;
import ballerina/lang.runtime;

// Number of requests to send
configurable int requestCount = 50;

public function main() returns error? {
    string activeNamedGroups = getActiveNamedGroups();
    
    io:println("Active TLS named groups from environment: " + activeNamedGroups);
    
    io:println("Sending " + requestCount.toString() + " requests to secure server...");

    // Array to store timing results in microseconds
    decimal[] timings = [];
    
    // Send multiple requests and measure time for each
    int i = 0;
    while i < requestCount {
        // Create a new client for each request to force a new TLS handshake
        http:Client secureClient = check new("https://localhost:9090",
            secureSocket = {
                cert: "../resources/public.crt",
                // Enable TLS 1.3 with post-quantum support
                protocol: { 
                    name: "TLS", 
                    versions: ["TLSv1.3"] 
                }
            },
            poolConfig = {
                // Limit to one active connection at a time
                // Otherwise, the client pool will reuse the connection.
                maxActiveConnections: 1
            }
        );

        // Use nanoTime for more precise measurement
        decimal startTime = time:monotonicNow();
        
        // Make request to the server endpoint
        string _ = check secureClient->get("/greeting");
        
        decimal endTime = time:monotonicNow();
        
        // Calculate duration in micro seconds (monotonicNow returns seconds)
        decimal duration = (endTime - startTime) * 1000000;
        
        timings.push(duration);
        
        io:println("Request " + (i + 1).toString() + ": " + duration.toString() + " μs");
        
        // Let the client go out of scope naturally - no explicit close needed
        // The new client instance for the next request will force a new handshake
        
        i = i + 1;

        // Sleep for a short duration to avoid overwhelming the server
        runtime:sleep(0.01);
    }
    
    // Write results to CSV file
    string csvContent = "request_number,duration_microseconds\n";
    int requestNum = 1;
    foreach decimal timing in timings {
        csvContent = csvContent + requestNum.toString() + "," + timing.toString() + "\n";
        requestNum = requestNum + 1;
    }
    
    string filePath = "../results/timings.csv";
    check io:fileWriteString(filePath, csvContent);
    io:println("Results written to: " + filePath);
}
