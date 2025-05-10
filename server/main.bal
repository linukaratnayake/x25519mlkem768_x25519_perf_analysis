import ballerina/http;
import ballerina/io;

// Configure HTTPS listener with certificates
listener http:Listener secureListener = new(9090, 
    secureSocket = {
        key: {
            certFile: "../resources/public.crt",
            keyFile: "../resources/private.key"
        }
        // Configure for X25519MLKEM768 support (requires OpenSSL 3.2+ with PQ support)
        // protocol: { name: "TLS", versions: ["1.3"] }
        // ciphers: ["TLS_AES_256_GCM_SHA384"]
        // Note: X25519MLKEM768 group selection may require specific OpenSSL version
        // with post-quantum support and custom Ballerina configuration
    }
);

// Simple service with one endpoint
service / on secureListener {
    resource function get greeting() returns string {
        return "Hello, World from secure HTTPS server!";
    }
}

public function main() {
    io:println("HTTPS server started on port 9090");
    io:println("Access the service at https://localhost:9090/greeting");
    // Server continues running as the service is bound to the listener
    // The program will keep running until manually terminated
}
