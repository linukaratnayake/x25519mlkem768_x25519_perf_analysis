import ballerina/http;
import ballerina/io;

// Configure HTTPS listener with certificates
listener http:Listener secureListener = new(9090, 
    secureSocket = {
        key: {
            certFile: "../resources/public.crt",
            keyFile: "../resources/private.key"
        },
        // Enable TLS 1.3 with post-quantum support
        protocol: { 
            name: "TLS", 
            versions: ["TLSv1.3"] 
        }
    }
);

// Simple service with one endpoint
service / on secureListener {
    resource function get greeting() returns string {
        return "Hello, World from secure HTTPS server.";
    }
}

public function main() {
    string activeNamedGroups = getActiveNamedGroups();
    
    io:println("HTTPS server started on port 9090");
    io:println("Active TLS named groups from environment: " + activeNamedGroups);
    io:println("Access the service at https://localhost:9090/greeting");
}
