#!/bin/bash

#!/bin/bash
LOGS_FOLDER="/var/log/expense-shell/"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1) 
TIME_STAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIME_STAMP.log"
 sudo mkdir -p $LOGS_FOLDER

 CHECK_ROOT(){
  if [$userid -ne 0]
  then
  echo "please run this script with root previlages"|tee -a $LOG_FILE
  exit 1
  fi
   }

  VALIDATE(){
    if [$1 -ne 0]
    then
    echo "$2 is failed.." |tee -a $LOG_FILE
    exit 1
    echo "$2 is success.." |tee -a $LOG_FILE
  } 

CHECK_ROOT

 dnf install mysql -y &>>$LOG_FILE
 VALIDATE $? "installing mysql server" 

 systemctl enable mysql -y &>>$LOG_FILE
 VALIDATE $? "enabling mysql server"

 systemctl start mysql -y &>>$LOG_FILE
 VALIDATE $? "starting mysql server"

 mysql_secure_installation --set-root-pass expenseapp@1 &>>$LOG_FILE
 VALIDATE $? "setting root_password"
