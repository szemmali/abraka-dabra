#!/bin/bash
##=================================================================================
##		 Project:  abraka-dabra
##        AUTHOR:  Eng. Saddam ZEMMALI
##       CREATED:  17.04.2018 00:03:01
##      REVISION:  ---
##       Version:  1.0  ¯\_(ツ)_/¯
##    Repository:  https://github.com/szemmali/abraka-dabra.git
##	    	Task:  Install SonarQUbe + PostgreSQL 9.6 
##          FILE:  GitLAB-Install.sh 
##   Description:  This script will Install and Configure GitLAB + Postfix
##                 on RedHat/CentOS 7
##   Requirement:  --
##			Note:  -- 
##          BUGS:  ---
##=================================================================================

echo "╔═══════════════════════════════════════════════════════╗"
echo "║ 	       Postfix User Guide                         ║"
echo "╚═══════════════════════════════════════════════════════╝"
sudo yum update –y
sudo yum install postfix -y

echo "start automatically whenever CentOS boots on your system"
sudo systemctl start postfix
sudo systemctl enable postfix

sudo yum install curl policycoreutils -y

echo "Getting Access through the Firewall"
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https

echo "restart the firewalld service to reflect the changes made in the above step"
sudo systemctl reload firewalld

echo "╔═══════════════════════════════════════════════════════╗"
echo "║ 	       GitLAB User Guide                          ║"
echo "╚═══════════════════════════════════════════════════════╝"
echo "use wget or curl command interchangeably to download the script file as follows."
wget https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh

echo "We run the script file using the bash command as follows."
sudo bash script.rpm.sh

echo " Install GitLab server Community Edition"
sudo yum install gitlab-ce

echo "This step is meant for the initial configuration."
sudo gitlab-ctl reconfigure

echo "╔═══════════════════════════════════════════════════════╗"
echo "║ 	     let's enjoy with GitLAB                      ║"
echo "╚═══════════════════════════════════════════════════════╝"




