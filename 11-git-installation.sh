#!/bin/bash

USERID=$(id -u)
#echo "user id is: $USERID"

if [ $USERID -ne 0 ]
then
   echo "Please run this script with root privilages"
   exit 1
fi

   apt list installed git 

if [ $? -ne 0 ]
then
   echo "git is allready installed, going to install it.."
   apt update

   apt install git -y

else
    echo "git is already installed, nothing do it.."

fi   