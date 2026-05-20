#!/bin/bash

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(basename "$0" | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"

mkdir -p "$LOGS_FOLDER"

CHECK_ROOT() {
    if [ "$USERID" -ne 0 ]; then
        echo -e "$R Please run this script with root privileges $N" | tee -a "$LOG_FILE"
        exit 1
    fi
}

VALIDATE() {
    if [ $1 -ne 0 ]; then 
        echo -e "$2 ... $R FAILED $N" | tee -a "$LOG_FILE"
        exit 1
    else
        echo -e "$2 ... $G SUCCESS $N" | tee -a "$LOG_FILE"
    fi
}

USAGE() {
    echo -e "$R USAGE :: sudo sh 21-redirectors-usage.sh package1 package2 ... $N"
    exit 1
}

CHECK_ROOT

if [ $# -eq 0 ]; then
   USAGE
fi

# Update once
apt update -y >> "$LOG_FILE" 2>&1
VALIDATE $? "APT UPDATE"

##################################
# PACKAGE INSTALLATION LOOP
##################################

for package in "$@"
do
    if dpkg -s "$package" &> /dev/null; then
        echo -e "$package is already installed...nothing to do" | tee -a "$LOG_FILE"
    else
        echo "$package is not installed. Installing..." | tee -a "$LOG_FILE"
        apt install -y "$package" >> "$LOG_FILE" 2>&1
        VALIDATE $? "Installing $package"
    fi
done
