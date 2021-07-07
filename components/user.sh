#!/bin/bash
source components/common.sh

OS_PREREQ

Head "Adding user"
useradd -m -s /bin/bash todo &>>$LOG

Head "Changing directory"
cd /home/todo/

DOWNLOAD_COMPONENT

apt update

Head "Installing Java"
apt install openjdk-8-jre-headless -y &>>$LOG
apt install openjdk-8-jdk-headless -y &>>$LOG

Head "Exporting java-jdk to JAVA_HOME"
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

Head "Installing Maven"
apt install maven -y &>>$LOG
cd /home/todo/users/
mvn clean package &>>$LOG

Head "Change directory to target folder"
cd target/

java -jar users-api-0.0.1.jar
