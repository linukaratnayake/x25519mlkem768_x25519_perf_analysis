import ballerina/os;

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

// Get active TLS named groups from environment variables
public function getActiveNamedGroups() returns string {
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
    
    return activeNamedGroups;
}
