#!/bin/bash

PACKAGE="nginx"
if dpkg -s $PACKAGE &> /dev/null;
then
   echo "$PACKAGE is already installed"
   
else
   echo "$PACKAGE is not installed. installing.."
   apt update
   apt install nginx -y
fi