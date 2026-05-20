#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0"

CHECK_ROOT() {
    if [ "$USERID" -ne 0 ]; then
        echo "Please run this script with root privileges"
        exit 1
    fi
}

VALIDATE() {
    if [ $1 -ne 0 ]; then 
        echo -e "$2 ...$R FAILED $N"
        exit 1
    else
        echo -e "$2 ...$G SUCCESS $N"
    fi
}

CHECK_ROOT

# sh 19-package is installing multiple packages git,mysql,postfix,nginx,redis


for package in "$@"   # "$@" expands to all arguments passed to the script
do
    dpkg list installed "$package" &>/dev/null
    if [ $? -ne 0 ]; then
        echo "$package is not installed. Going to install..."
        apt install -y "$package"
        VALIDATE $? "Installing $package"
    else
        echo "$package is already installed... nothing to do"
    fi
done
