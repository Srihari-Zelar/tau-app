#!/bin/bash

source components/common.sh

#Used export instead of service file
DOMAIN=ksrihari.online

OS_PREREQ

Head "Installing npm"
apt install npm -y &>>$LOG

Head "Adding user"
useradd -m -s /bin/bash todo &>>$LOG

Head "Changing directory"
cd /home/todo/

DOWNLOAD_COMPONENT

cd todo/

Head "Installing NPM"
npm install -y &>>$LOG

Head "Configure environmental variables"
export REDIS_PORT=6379
export REDIS_HOST=redis.$DOMAIN

Head "Start npm"
npm start
Stat $?
