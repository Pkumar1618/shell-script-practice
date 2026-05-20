
#!/bin/bash

USERID=$(id -u)

CHECK_ROOT() {
    if [ "$USERID" -ne 0 ]; then
        echo "Please run this script with root privileges"
        exit 1
    fi
}

VALIDATE() {
    if [ $1 -ne 0 ]; then 
        echo "$2 ... FAILED"
        exit 1
    else
        echo "$2 ... SUCCESS"
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
fi