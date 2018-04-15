#!/bin/bash
##=================================================================================
##		 Project:  abraka-dabra
##        AUTHOR:  Eng. Saddam ZEMMALI
##       CREATED:  15.04.2018 20:10:01
##      REVISION:  ---
##       Version:  1.0  ¯\_(ツ)_/¯
##    Repository:  https://github.com/szemmali/abraka-dabra.git
##	    	Task:  Install LAMP (MySQL8) 
##          FILE:  Task-Install-LAMP-(MySQL8).sh
##   Description:  This script will Install and Configure LAMP (MySQL8)
##                 on RedHat/CentOS 7
##   Requirement:  --
##			Note:  -- 
##          BUGS:  ---
##=================================================================================

echo "╔═══════════════════════════════════════════════════════╗"
echo "║ 	 Install PHP Repo User Guide [7]                  ║"
echo "╚═══════════════════════════════════════════════════════╝"
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo rpm -Uvh remi-release-7.rpm epel-release-latest-7.noarch.rpm


echo "╔═══════════════════════════════════════════════════════╗"
echo "║ 	   Install Apache/PHP User Guide                  ║"
echo "╚═══════════════════════════════════════════════════════╝"
sudo yum install yum-utils
sudo yum --enablerepo=remi,remi-php71 install httpd php php-common
sudo yum-config-manager --enable remi-php71


echo "╔═══════════════════════════════════════════════════════╗"
echo "║ 	   Install Required PHP Modules                   ║"
echo "╚═══════════════════════════════════════════════════════╝"
sudo yum --enablerepo=remi,remi-php71 install php-cli php-pear php-pdo php-mysqlnd php-pgsql php-gd php-mbstring php-mcrypt php-xml


echo "╔═══════════════════════════════════════════════════════╗"
echo "║ 	   Install Composer User Guide                    ║"
echo "╚═══════════════════════════════════════════════════════╝"
curl -sS https://getcomposer.org/installer | php

sudo mv composer.phar /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer 


echo "╔═══════════════════════════════════════════════════════╗"
echo "║ 	   Manage Apache Service 		                  ║"
echo "╚═══════════════════════════════════════════════════════╝"
sudo systemctl start httpd.service 
sudo systemctl enable httpd.service
sudo firewall-cmd --permanent --zone=public --add-port=80/tcp


echo "╔═══════════════════════════════════════════════════════╗"
echo "║ 	   Install MySQL 8.0/5.7		                  ║"
echo "╚═══════════════════════════════════════════════════════╝"
echo "Enable MySQL Yum Repository"
sudo rpm -Uvh https://repo.mysql.com/mysql57-community-release-el7-11.noarch.rpm

#echo "Install MySQL 5.7"
#sudo yum install mysql-community-server 

echo "Install MySQL 8.0:"
sudo yum --enablerepo=mysql80-community install mysql-community-server

echo "Find MySQL root Password"
grep "A temporary password" /var/log/mysqld.log

echo "Enable  MySQL Service Using Systemd"
sudo systemctl enable mysqld.service

echo "Start MySQL Service Using SysVinit"
service mysqld start

echo "Start MySQL Service Using Systemd"
sudo systemctl start mysqld.service

echo "Add New Rule to Firewalld"
sudo firewall-cmd --permanent --zone=public --add-service=mysql