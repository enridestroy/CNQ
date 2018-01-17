#how to install/reinstall fresh tomcat and josso (fast simple) for Centos 7.4+
#2018-01-05 GF
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi
systemctl stop tomcat ; \
sleep 5 ; \
cd ; \
rm -R -f /opt/tomcat ; \
rm -R -f /josso-1* ; \
mkdir /opt/tomcat ; \
chown -R tomcat:tomcat /opt/tomcat ; \
cd ; \
CATALINA_HOME=/opt/tomcat
export CATALINA_HOME
vTOMCAT_SSL=-Djava.library.path=/usr/local/apr/lib
vTOMCAT=7.0.82 ; \
vREL=7 ; vMAJOR=0 ; \
wget -nc http://www-us.apache.org/dist/tomcat/tomcat-$vREL/v$vTOMCAT/bin/apache-tomcat-$vTOMCAT.tar.gz ; \
tar -zxf apache-tomcat-$vTOMCAT.tar.gz -C /opt/tomcat --strip-components=1 ; \
cd /opt/tomcat ; \
chgrp -R tomcat conf ; \
chmod g+rwx conf ; \
chmod g+r conf/* ; \
chown -R tomcat logs/ temp/ webapps/ work/ ; \
chgrp -R tomcat bin ; \
chgrp -R tomcat lib ; \
chmod g+rwx bin ; \
chmod g+r bin/* ; \
export JAVA_HOME=/usr/lib/jvm/jre ; JAVA_HOME=/usr/lib/jvm/jre ; \
sleep 3
cat > /etc/systemd/system/tomcat.service <<-EOM
[Unit]
Description=Apache Tomcat Web Application Container
After=syslog.target network.target
[Service]
Type=forking
Environment=JAVA_HOME=/usr/lib/jvm/jre
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='CATALINA_OPTS=-Xms2048M -Xmx16384M -server -XX:+UseParallelGC ${vTOMCAT_SSL}'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'
ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/bin/kill -15 $MAINPID
User=tomcat
Group=tomcat
[Install]
WantedBy=multi-user.target
EOM
sleep 3
cat > /opt/tomcat/conf/tomcat-users.xml <<-EOM
<?xml version='1.0' encoding='utf-8'?>
<tomcat-users xmlns="http://tomcat.apache.org/xml"
              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd"
              version="1.0">
  <user username="tomcat" password="s3cret" roles="manager-gui,admin-gui,manager-script"/>
</tomcat-users>
EOM
sleep 3 ; systemctl start tomcat.service ; systemctl enable tomcat.service ; systemctl status tomcat
sleep 3 ; \
vJOSSO=1.8.7 ; \
env | grep JAVA_HOME ; \
cd ; \
wget -nc https://sourceforge.net/projects/josso/files/JOSSO/JOSSO-$vJOSSO/josso-$vJOSSO.tar.gz ; \
tar -zxf josso-$vJOSSO.tar.gz -C /
cd /josso-$vJOSSO/bin ; \
echo gateway install --target /opt/tomcat --platform tc$vREL$vMAJOR ; \
echo agent install --target /opt/tomcat --platform tc$vREL$vMAJOR ; \
echo samples install --target /opt/tomcat --platform tc$vREL$vMAJOR ; \
echo exit ; \
./josso-gsh
