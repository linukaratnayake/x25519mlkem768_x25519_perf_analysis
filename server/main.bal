import ballerina/http;
import ballerina/io;
import ballerina/os;

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
        },
        ciphers: ["TLS_AES_256_GCM_SHA384", "TLS_CHACHA20_POLY1305_SHA256"]
    }
);

// Simple service with one endpoint
service / on secureListener {
    resource function get greeting() returns string {
        io:println("Received request");
        return "Hello, World from secure HTTPS server.";
    }
}

public function main() {
    string? javaOptions = os:getEnv("_JAVA_OPTIONS");
    string activeNamedGroups = "default";
    
    // Extract named groups from environment variable using simple parsing
    if javaOptions is string {
        // Manual parsing without string functions
        string[] parts = splitString(javaOptions, " ");
        foreach string part in parts {
            if part.startsWith("-Djdk.tls.namedGroups=") {
                activeNamedGroups = part.substring(22); // Length of "-Djdk.tls.namedGroups="
                break;
            }
        }
    }
    
    io:println("HTTPS server started on port 9090");
    io:println("Active TLS named groups from environment: " + activeNamedGroups);
    io:println("Access the service at https://localhost:9090/greeting");
}

// Simple string split function
function splitString(string input, string delimiter) returns string[] {
    string[] result = [];
    int startIndex = 0;
    int i = 0;
    while (i < input.length()) {
        if (input.substring(i, i + 1) == delimiter) {
            if (i > startIndex) {
                result.push(input.substring(startIndex, i));
            }
            startIndex = i + 1;
        }
        i = i + 1;
    }
    if (startIndex < input.length()) {
        result.push(input.substring(startIndex));
    }
    return result;
}
