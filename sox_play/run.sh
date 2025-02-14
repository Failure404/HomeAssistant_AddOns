#!/bin/bash

set -e

echo "Starting..."

# Trap signals to handle unexpected termination
trap 'echo "[Error] Terminated unexpectedly"; exit 1' SIGINT SIGTERM
trap 'echo "[Error] Broken pipe (connection closed)"; continue' SIGPIPE

# Read from STDIN aliases to play file
while true; do
    while read -r input; do
        echo "[Info] Parameters: $input"
        
        # Removing JSON stuff
        input=$(echo "$input" | jq --raw-output '.')
        #echo "[Info] Processed parameters: $input"
        
        # Playing the input file
        if ! msg="$(play $input)"; then
            echo "[Error] Playing failed"
        fi
    done
done
