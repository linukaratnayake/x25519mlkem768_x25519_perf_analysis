import ballerina/http;
import ballerina/io;

public function main() returns error? {
    // Configure HTTP client with TLS settings
    http:Client secureClient = check new("https://localhost:9090",
        secureSocket = {
            cert: "../resources/public.crt",
            // Enable TLS 1.3 with post-quantum support
            protocol: { 
                name: "TLS", 
                versions: ["TLSv1.3"] 
            }
        }
    );

    string activeNamedGroups = getActiveNamedGroups();
    
    io:println("Sending request to secure server...");
    io:println("Active TLS named groups from environment: " + activeNamedGroups);
    
    // Make request to the server endpoint
    string response = check secureClient->get("/greeting");
    
    io:println("Server response: " + response);
}
