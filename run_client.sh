#!/bin/bash

# Go to the directory where the client code is located
cd client

export _JAVA_OPTIONS="-Djdk.tls.namedGroups=x25519"
bal run
mv ../results/timings.csv ../results/timings_x25519.csv

export _JAVA_OPTIONS="-Djdk.tls.namedGroups=X25519MLKEM768,x25519"
bal run
mv ../results/timings.csv ../results/timings_hybrid.csv
