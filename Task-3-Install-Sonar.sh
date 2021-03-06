#!/bin/bash
##=================================================================================
##		 Project:  abraka-dabra
##        AUTHOR:  Eng. Saddam ZEMMALI
##       CREATED:  15.04.2018 20:10:01
##      REVISION:  ---
##       Version:  1.0  ¯\_(ツ)_/¯
##    Repository:  https://github.com/szemmali/abraka-dabra.git
##	    	Task:  Install SonarQUbe + PostgreSQL 9.6 
##          FILE:  Task-3-Install-Sonar.sh 
##   Description:  This script will Install and Configure SonarQUbe + PostgreSQL
##                 on RedHat/CentOS 7
##   Requirement:  --
##			Note:  -- 
##          BUGS:  ---
##=================================================================================

echo "╔═══════════════════════════════════════════════════════╗"
echo "║ 	   PostgreSQL  User Guide [9.6]                   ║"
echo "╚═══════════════════════════════════════════════════════╝"

wget https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7.3-x86_64/pgdg-redhat96-9.6-3.noarch.rpm
sudo yum -y localinstall pgdg-redhat96-9.6-3.noarch.rpm
sudo yum install -y postgresql96-server

echo "Start PostgreSQL service"
sudo /usr/pgsql-9.6/bin/postgresql96-setup initdb
sudo systemctl enable postgresql-9.6.service
sudo systemctl start postgresql-9.6.service
 

echo "Configure PostgreSQL DBSonar"
su postgres
/usr/pgsql-9.6/bin/pg_ctl reload -D /var/lib/pgsql/9.6/data/

sudo -u postgres createuser sonar
sudo -u postgres createdb sonarqube
sudo -u postgres psql

# alter user sonar with encrypted password 'userpwd';
# grant all privileges on database sonar to sonarqube ;


echo "╔═══════════════════════════════════════════════════════╗"
echo "║ 	    SonarQUbe  User Guide                         ║"
echo "╚═══════════════════════════════════════════════════════╝"
echo "Install Sonar repo"
wget -O /etc/yum.repos.d/sonar.repo http://downloads.sourceforge.net/project/sonar-pkg/rpm/sonar.repo
sudo yum -y install sonar

echo "Start MySQL Service Using Systemd"
sudo systemctl start httpd.service 
sudo systemctl enable httpd.service

echo "Add New Rule to Firewalld"
sudo firewall-cmd --permanent --zone=public --add-port=9000/tcp