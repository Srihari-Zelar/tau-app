#!/bin/bash

source components/common.sh

#Used export instead of service file
DOMAIN=ksrihari.online


OS_PREREQ

Head "Adding user"
useradd -m -s /bin/bash todo &>>$LOG

Head "Changing directory to todo"
cd /home/todo/

Head "Installing go language"
wget -c https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local &>>$LOG


go version


~/.profile

Head "Exporting to path"
export PATH=$PATH:/usr/local/go/bin

source ~/.profile

Head "Creating a directory go"
mkdir ~/go &>>$LOG


mkdir -p ~/go/src &>>$LOG


cd  ~/go/src/

DOWNLOAD_COMPONENT


cd login/


apt update

Head "Installing go-dep"

apt install go-dep &>>$LOG

go get &>>$LOG

go build &>>$LOG


Head "Configure Environmental Variables"

export AUTH_API_PORT=8080
export USERS_API_ADDRESS=http://user.$DOMAIN:8080

Head "Restart Service"
./login
