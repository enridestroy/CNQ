#how to build Tomcat 7 with SSL and APR/Native 
# 2018-01-10 GF
yum install -y openssl-devel
yum groupinstall -y "Development Tools"
yum install -y expat-devel
wget http://httpd-mirror.sergal.org/apache/apr/apr-1.6.3.tar.gz ; \
tar -zxvf apr-1.6.3.tar.gz ; \
cd apr-1.6.3 ; ./configure ; make ; make install ; cd 
sleep 5
wget http://httpd-mirror.sergal.org/apache/apr/apr-util-1.6.1.tar.gz ; \
tar -zxvf apr-util-1.6.1.tar.gz ; \
cd apr-util-1.6.1 ; ./configure --with-apr=/usr/local/apr ; make ; make install ; cd 
sleep 5
cd /opt/tomcat/bin
wget http://apache.mirror.iweb.ca/tomcat/tomcat-connectors/native/1.2.16/source/tomcat-native-1.2.16-src.tar.gz ; \
tar -zxvf tomcat-native-1.2.16-src.tar.gz
cd /opt/tomcat/bin/tomcat-native-1.2.16-src/native
./configure --with-apr=/usr/local/apr --with-java-home=/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.161-2.6.12.0.el7_4.x86_64
make
make install
cd

#self sign certificate
openssl genrsa -des3 -out server.key 1024
openssl req -new -key server.key -out server.csr
cp server.key server.key.org
openssl rsa -in server.key.org -out server.key
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
keytool -import -alias tomcat -keystore /opt/tomcat/.keystore -file server.crt
