#!/bin/bash


LOGS_FOLDER="/var/log/expense-shell/"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1) 
TIME_STAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIME_STAMP.log"
userid=$(id -u) # <-- Added this to get the current user ID
 mkdir -p "$LOGS_FOLDER"

 CHECK_ROOT(){
  if [ $userid -ne 0 ]
  then
    echo "please run this script with root previlages"|tee -a $LOG_FILE
    exit 1
  else
    echo "the script was already in root.." | tee -a $LOG_FILE
  fi
  }

  VALIDATE(){
    if [ $1 -ne 0 ]
    then
       echo "$2 is failed.." | tee -a $LOG_FILE
       exit 1
    else
       echo "$2 is success.." | tee -a $LOG_FILE
    fi
  } 

CHECK_ROOT
 mkdir -p "$LOGS_FOLDER"
 dnf install -y https://mysql.com 
 VALIDATE $? "installing mysql server" 

 systemctl enable mysqld  
 VALIDATE $? "enabling mysql server"

 systemctl start mysqld  
 VALIDATE $? "starting mysql server"
 
 mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'expenseapp@1'
 VALIDATE $? "Configuring secure root password"

