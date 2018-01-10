cd
wget -nc https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/javamelody/javamelody-1.49.0.war
if [[ ! -f /opt/tomcat/conf/web.xml.bak ]] ; then
cp /opt/tomcat/conf/web.xml /opt/tomcat/conf/web.xml.bak
cat > /opt/tomcat/conf/web.xml.add <<-EOM

<filter>
        <filter-name>monitoring</filter-name>
        <filter-class>net.bull.javamelody.MonitoringFilter</filter-class>
</filter>
<filter-mapping>
        <filter-name>monitoring</filter-name>
        <url-pattern>/*</url-pattern>
</filter-mapping>
<listener>
        <listener-class>net.bull.javamelody.SessionListener</listener-class>
</listener>

EOM
sed -e '462 r /opt/tomcat/conf/web.xml.add' /opt/tomcat/conf/web.xml.bak > /opt/tomcat/conf/web.xml
fi