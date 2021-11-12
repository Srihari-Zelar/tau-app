#!/bin/bash

source components/common.sh

#Used export instead of service file
DOMAIN=ksrihari.online

OS_PREREQ

Head "Installing Nginx"
apt install nginx -y &>>$LOG
Stat $?

Head "Installing npm and nodejs"
apt install npm -y &>>$LOG
Stat $?

Head "Create directory"
cd /var/www/html/
mkdir todo  &>>$LOG
cd todo
Stat $?

DOWNLOAD_COMPONENT

cd frontend

Head "Installing npm"
npm install -y &>>$LOG
Stat $?

Head "run and build npm"
npm install node-sass &>>$LOG
npm run build &>>$LOG
sudo npm install --save-dev  --unsafe-perm node-sass &>>$LOG
Stat $?

Head "Update Nginx Configuration"
  sed -i 's+/var/www/html+/var/www/html/todo/frontend/dist+g' /etc/nginx/sites-available/default
Stat $?

Head "Restart nginx service"
nginx -t && service nginx restart && systemctl enable nginx
systemctl restart nginx
Stat $?

Head "Configure environmental variables"
cd /var/www/html/todo/frontend
export AUTH_API_ADDRESS=http://login.$DOMAIN:8080
export TODOS_API_ADDRESS=http://todo.$DOMAIN:8080
Stat $?

Head "Start npm"
npm start
Stat $?
