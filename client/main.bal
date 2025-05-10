import ballerina/http;
import ballerina/io;

public function main() returns error? {
    // Configure HTTP client with TLS settings
    http:Client secureClient = check new("https://localhost:9090",
        secureSocket = {
            cert: "../resources/public.crt"
            // Configure for X25519MLKEM768 support
            // protocol: { name: "TLS", versions: ["1.3"] }
            // ciphers: ["TLS_AES_256_GCM_SHA384"]
            // Note: Ensure the server supports the configured protocol and ciphers
        }
    );

    io:println("Sending request to secure server...");
    
    // Make request to the server endpoint
    string response = check secureClient->get("/greeting");
    
    io:println("Server response: " + response);
    io:println("TLS connection successful!");
}
