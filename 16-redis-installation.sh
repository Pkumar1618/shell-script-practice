#!/bin/bash

USERID=$(id -u)

if [ "$USERID" -ne 0 ]; then
   echo "Please run this script with root privileges"
   exit 1
fi

# Update once
  apt update -y

########################
# GIT
########################
if dpkg -s git &> /dev/null; then
   echo "git is already installed"
else
   echo "git is not installed. Installing..."
   
   apt install -y git
fi

########################
# REDIS
########################
if dpkg -s redis-server &> /dev/null; then
   echo "redis-server is already installed"
else
   echo "redis-server is not installed. Installing..."
   apt install -y redis-server
fi