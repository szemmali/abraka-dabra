#!/bin/bash
##==================================================================================
##		 Project:  abraka-dabra
##        AUTHOR:  Eng. Saddam ZEMMALI
##       CREATED:  15.04.2018 20:10:01
##      REVISION:  ---
##       Version:  1.0  ¯\_(ツ)_/¯
##    Repository:  https://github.com/szemmali/abraka-dabra.git
##	    	Task:  INSTALL AND CONFIGURE Jenkins on REDHAT 7
##          FILE:  install_jenkins.sh
##   Description:  This script will Install and Configure Jenkins on RedHat/CentOS 7
##   Requirement:  --
##			Note:  -- 
##          BUGS:  ---
##==================================================================================

echo "╔═══════════════════════════════════════╗"
echo "║     Install and Enable EPEL REPO      ║"
echo "╚═══════════════════════════════════════╝"

echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolv.conf
echo "nameserver 8.8.4.4" | sudo tee -a /etc/resolv.conf

echo "Install last EPEL Repo"
sudo yum -y localinstall https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

sudo yum -y update
sudo yum clean expire-cache

echo "╔═══════════════════════════════════════╗"
echo "║     install Jenkins on RedHat 7       ║"
echo "╚═══════════════════════════════════════╝"
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install jenkins


echo "╔═══════════════════════════════════════╗"
echo "║     install JAVA on RedHat 7          ║"
echo "╚═══════════════════════════════════════╝"
sudo yum install java-1.8.0-openjdk.x86_64
java -version

echo $JAVA_HOME
echo $JRE_HOME

sudo cp /etc/profile /etc/profile_backup
ls /usr/lib/jvm/jre-1.8.0-openjdk

echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | sudo tee -a /etc/profile
ls /usr/lib/jvm/jre

echo 'export JRE_HOME=/usr/lib/jvm/jre' | sudo tee -a /etc/profile
source /etc/profile

echo $JAVA_HOME
echo $JRE_HOME

echo "╔═══════════════════════════════════════╗"
echo "║ Start and enable Jenkins on RedHat 7  ║"
echo "╚═══════════════════════════════════════╝"
echo "Start Jenkins Service Using Systemd"
sudo systemctl start jenkins.service

echo "Enable Jenkins Service Using Systemd"
sudo systemctl enable jenkins.service

netstat -ntlp | grep 8080

echo "╔═══════════════════════════════════════╗"
echo "║     Add New Rule to Firewalld         ║"
echo "╚═══════════════════════════════════════╝"
sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp
sudo firewall-cmd --reload
firewall-cmd --list-all
sudo systemctl stop firewalld.service
sudo systemctl disable firewalld.service

cat /var/lib/jenkins/secrets/initialAdminPassword