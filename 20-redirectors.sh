#!/bin/bash

LOGS_FOLDER="/var/log/shell-script" 
SCRIPT_NAME=$(echo $0 | cut -d "." -f1) # echo "20-redirectories.sh" | cut -d "." -f1
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"
mkdir -p $LOGS_FOLDER


USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0"

CHECK_ROOT() {
    if [ "$USERID" -ne 0 ]; then
        echo -e "$R Please run this script with root privileges $N" &>>$LOG_FILE
        exit 1
    fi
}

VALIDATE() {
    if [ $1 -ne 0 ]; then 
        echo -e "$2 ...$R FAILED $N" &>>$LOG_FILE
        exit 1
    else
        echo -e "$2 ...$G SUCCESS $N" &>>$LOG_FILE
    fi
}

USAGE(){
    echo -e "$R USAGE :: $N sudo sh 20-redirectors.sh package1 package2 ..."
    exit 1
}
CHECK_ROOT

if [ $# -eq 0 ] 
then
   USAGE
fi
# Update once
apt update -y &>> $LOG_FILE 
VALIDATE $? "APT UPDATE"

# sh 19-package is installing multiple packages git,mysql,postfix,nginx,redis

for package in "$@"   # "$@" expands to all arguments passed to the script
do
    dpkg list installed $package &>/dev/null &>>$LOG_FILE
    if [ $? -ne 0 ]; then
        echo "$package is not installed. Going to install..." &>>$LOG_FILE
        apt install -y $package &>>$LOG_FILE
        VALIDATE $? "Installing $package"
    else
        echo -e "$package is already $Y installed..nothing to do $N" &>>$LOG_FILE
    fi
done