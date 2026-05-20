#!/bin/bash

PACKAGE="nginx"

# Check if package is installed
if dnf list installed $PACKAGE &> /dev/null; then
    echo "$PACKAGE is already installed"
else
    echo "$PACKAGE is not installed. Installing..."
    dnf -y install $PACKAGE
    if [ $? -eq 0 ]; then
        echo "$PACKAGE installation successful"
        systemctl enable $PACKAGE
        systemctl start $PACKAGE
        echo "$PACKAGE service started"
    else
        echo "Failed to install $PACKAGE"
        exit 1
    fi
fi
