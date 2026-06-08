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
  echo "script started executing at $(date)" | tee-a $LOG_FILE

  