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
cp /opt/tomcat/conf/server.xml /opt/tomcat/conf/server.xml.bak
cat > /opt/tomcat/conf/server.xml.add <<-EOM
 <Connector port="8443" protocol="org.apache.coyote.http11.Http11AprProtocol"
            maxThreads="1500" SSLEnabled="true" scheme="https" secure="true"
            clientAuth="false"
            SSLCertificateFile="${catalina.base}/conf/server.crt"
            SSLCertificateKeyFile="${catalina.base}/conf/server.key"
            SSLProtocol="all"
  />

EOM
sed -e '56 r /opt/tomcat/conf/server.xml.add' /opt/tomcat/conf/server.xml.bak > /opt/tomcat/conf/server.xml
chown -R tomcat:tomcat /opt
