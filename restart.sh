#!/bin/bash

app_name="ppm.jar"

# Search for processes containing "abc.xx" in their names
processes=$(ps aux | grep ${app_name} | grep -v "grep")

# Check if any matching processes were found
if [ -n "$processes" ]; then
    # Loop through the matching processes and kill them
    echo "Killing processes with names containing 'abc.xx':"
    echo "$processes"
    echo "$processes" | while read -r line; do
        pid=$(echo "$line" | awk '{print $2}')
        echo "Killing process with PID $pid"
        kill "$pid"
    done
else
    echo "No processes found with names containing 'abc.xx'"
fi

nohup java -jar ./ppm.jar --server.port=8092 >log 2>&1 &
