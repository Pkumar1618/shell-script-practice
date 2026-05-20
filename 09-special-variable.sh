#!/bin/bash

# Special Variable

echo "All variables passed through the script: $@"
echo "Number of variables passed: $#"
echo "script name: $0"
echo "current working directory: $PWD"
echo "home directory of current user: $HOME"
echo "PID of the script executing now: $$"
sleep 100 &
echo "PID of last background command: $!"
echo "how will you check the previous command success or not: $?"