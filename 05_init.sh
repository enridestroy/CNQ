cp -f /opt/tomcat/conf/tomcat-users.xml /opt/tomcat/conf/tomcat-users.xml.old
sed 's/manager-gui,admin-gui,manager-script/manager-gui,admin-gui/g' \
/opt/tomcat/conf/tomcat-users.xml.old > /opt/tomcat/conf/tomcat-users.xml.new
sed 's/manager-gui,admin-gui/manager-gui,admin-gui,manager-script/g' \
/opt/tomcat/conf/tomcat-users.xml.new > /opt/tomcat/conf/tomcat-users.xml
cp -f /home/panic/josso_cnq/josso.war/WEB-INF/lib/crowd-integration-client-2.6.2.jar /opt/tomcat/webapps/josso/WEB-INF/lib/
cp -f /home/panic/josso_cnq/josso.war/WEB-INF/lib/crowd-integration-client-rest-2.6.2.jar /opt/tomcat/webapps/josso/WEB-INF/lib/
cp -f /home/panic/josso_cnq/josso.war/WEB-INF/lib/crowd.properties  /opt/tomcat/webapps/josso/WEB-INF/lib/
cp -f /home/panic/josso_cnq/josso.war/WEB-INF/lib/crowd-proxy-0.0.1-SNAPSHOT.jar /opt/tomcat/webapps/josso/WEB-INF/lib/
cp -f /home/panic/josso_cnq/josso.war/WEB-INF/lib/slf4j-api-1.6.0.jar /opt/tomcat/webapps/josso/WEB-INF/lib/
cp -f /home/panic/josso_cnq/josso.war/WEB-INF/lib/slf4j-jcl-1.6.0.jar /opt/tomcat/webapps/josso/WEB-INF/lib/
cp -f /home/panic/josso_cnq/josso.war/WEB-INF/lib/josso-crowd-authscheme-1.8.7.jar /opt/tomcat/webapps/josso/WEB-INF/lib/
cp -f /home/panic/josso_cnq/josso.war/WEB-INF/lib/josso-crowd-identitystore-1.8.7.jar /opt/tomcat/webapps/josso/WEB-INF/lib/
cp /home/panic/josso_cnq/josso.war/WEB-INF/lib/google-collections-1.0.jar /opt/tomcat/webapps/josso/WEB-INF/lib/
cp /home/panic/josso_cnq/josso.war/WEB-INF/lib/xfire-aegis-1.2.6.jar /opt/tomcat/webapps/josso/WEB-INF/lib/
cp /home/panic/josso_cnq/josso.war/WEB-INF/lib/xfire-core-1.2.6.jar /opt/tomcat/webapps/josso/WEB-INF/lib/
cp /home/panic/josso_cnq/josso.war/WEB-INF/lib/atlassian-core-3.8.jar /opt/tomcat/webapps/josso/WEB-INF/lib/
cp /home/panic/josso_cnq/josso.war/WEB-INF/lib/atlassian-user-1.0.jar /opt/tomcat/webapps/josso/WEB-INF/lib/
cp /home/panic/josso_cnq/josso.war/WEB-INF/lib/atlassian-util-concurrent-4.0.0.jar /opt/tomcat/webapps/josso/WEB-INF/lib/
cp /home/panic/josso_cnq/josso.war/WEB-INF/lib/jaxb-impl-2.2.jar /opt/tomcat/webapps/josso/WEB-INF/lib/
cp /home/panic/josso_cnq/josso.war/WEB-INF/lib/commons-httpclient-3.0.jar /opt/tomcat/webapps/josso/WEB-INF/lib/
cp /home/panic/josso_cnq/josso.war/WEB-INF/lib/jdom-1.0.jar /opt/tomcat/webapps/josso/WEB-INF/lib/
cp /home/panic/josso_cnq/josso.war/WEB-INF/lib/jdom.jar /opt/tomcat/webapps/josso/WEB-INF/lib/
cp /home/panic/josso_cnq/josso.war/WEB-INF/lib/commons-logging-1.0.4.jar /opt/tomcat/webapps/josso/WEB-INF/lib/
cp -f /home/panic/josso_cnq/josso.war/WEB-INF/struts-signon.xml /opt/tomcat/webapps/josso/WEB-INF/
mv /opt/tomcat/webapps/josso/WEB-INF/lib/commons-logging-1.0.3.jar /opt/tomcat/webapps/josso/WEB-INF/lib/commons-logging-1.0.3.jar.old
cp -f /home/panic/josso_cnq/configs.old/* /opt/tomcat/lib/
cp -f /home/panic/josso_cnq/context_fix/josso-authentication.war /opt/tomcat/webapps/cnq_auth.war
#wget --http-user=tomcat --http-password=s3cret "http://localhost:8080/manager/text/undeploy?path=/cnq_auth" -O -
#wget --http-user=tomcat --http-password=s3cret "http://localhost:8080/manager/text/deploy?path=/cnq_auth&war=file:/home/panic/josso_cnq/context_fix/josso-authentication.war" -O -
echo "josso_authentication.war est installe dans /cnq_auth"
if [[ ! -f /opt/tomcat/lib/josso-gateway-web.xml.bak ]] ; then
  cp /opt/tomcat/lib/josso-gateway-web.xml /opt/tomcat/lib/josso-gateway-web.xml.bak
  sed 's/https:\/\/authentification.pp.cdnq.lan\/cnq_auth/http:\/\/ax03.pp.cdnq.lan:8080\/cnq_auth/g' /opt/tomcat/lib/josso-gateway-web.xml.bak > /opt/tomcat/lib/josso-gateway-web.xml
fi
touch /opt/tomcat/lib/ip-mappings.properties
echo "creation du fichier de ipmappings pour les universités"
#une fois seulement par systeme
#keytool -import -alias root_cnq -keystore \
#/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.161-2.6.12.0.el7_4.x86_64/jre/lib/security/cacerts \
#-file /home/panic/josso_cnq/cnq_root.cer
#optionel - non requis
#keytool -import -alias core_jboss -keystore \
#/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.161-2.6.12.0.el7_4.x86_64/jre/lib/security/cacerts \
#-file /home/panic/josso_cnq/core.jboss.pp.cdnq.lan.cer
echo "est-ce que le root certificate est dans le keystore global de JAVA?"
if [[ ! -f /opt/tomcat/conf/context.xml.bak ]] ; then
  cp /opt/tomcat/conf/context.xml /opt/tomcat/conf/context.xml.bak
  sed '36 a <Environment name="remoteObjectAccessor.host" value="core.jboss.pp.cdnq.lan" type="java.lang.String" override="false"\/>' /opt/tomcat/conf/context.xml.bak > /opt/tomcat/conf/c1.xml
  sed '36 a <Environment name="remoteObjectAccessor.port" value="1099" type="java.lang.String" override="false"\/>' /opt/tomcat/conf/c1.xml > /opt/tomcat/conf/c2.xml
  sed '36 a <Environment name="messagesFile.path" value="\/opt\/tomcat\/message.txt" type="java.lang.String" override="false"\/>' /opt/tomcat/conf/c2.xml > /opt/tomcat/conf/c3.xml
  sed '36 a <Environment name="ipmappings.path" value="file:/\\/opt\/tomcat\/lib\/" override="false"\/>' /opt/tomcat/conf/c3.xml > /opt/tomcat/conf/context.xml
fi
chown -R tomcat:tomcat /opt
systemctl stop tomcat ; sleep 2 ; systemctl start tomcat
echo "fini, merci"
