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

# Update once
  apt update -y
VALIDATE $? "APT UPDATE"

########################
# GIT
########################
if dpkg -s git &> /dev/null; then
    echo "git is already installed"
else
    echo "git is not installed, installing..."
    apt install -y git
    VALIDATE $? "INSTALLING GIT"
fi

########################
# MYSQL
########################
if dpkg -s mysql-server &> /dev/null; then
    echo "MySQL is already installed"
else
    echo "MySQL is not installed, installing..."
    apt install -y mysql-server
    VALIDATE $? "INSTALLING MYSQL"