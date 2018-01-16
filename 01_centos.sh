#howto install Centos 7.4 for Tomcat - fast and simple
# 2018-01-04 GF
#1 system
yum install -y epel-release ; \
yum repolist ; \
yum update -y ; \
yum upgrade ; \
yum install -y htop nano wget curl expat-devel openssl-devel ; \
yum groupinstall -y "Development Tools" ; \
systemctl stop firewalld ; systemctl disable firewalld ; \
echo "centos1.domain.net" > /etc/hostname ; \
cat /etc/hostname ; \
echo "wait 20s before reboot" ; sleep 20 ; \
reboot
#2 java jdk
#yum install java-1.8.0-openjdk-devel
yum install java-1.7.0-openjdk-devel
#3 tomcat security (avec root/sudo)
groupadd tomcat ; \
mkdir /opt ; \
mkdir /opt/tomcat ; \
useradd -s /bin/nologin -g tomcat -d /opt/tomcat tomcat
