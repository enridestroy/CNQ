#!/bin/bash
cd
vTOMCAT=/opt/tomcat
wget -nc --no-check-certificate https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/javamelody/javamelody-1.49.0.zip
unzip -o javamelody-1.49.0.zip jrobin-1.5.9.1.jar ; mv -f jrobin-1.5.9.1.jar $vTOMCAT/lib.
unzip -o javamelody-1.49.0.zip javamelody.jar ; mv -f javamelody.jar $vTOMCAT/lib/.
if [[ ! -f $vTOMCAT/conf/web.xml.bak ]] ; then
cp $vTOMCAT/conf/web.xml $vTOMCAT/conf/web.xml.bak
cat > $vTOMCAT/conf/web.xml.add <<-EOM

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
sed -e '455 r ${vTOMCAT}/conf/web.xml.add' $vTOMCAT/conf/web.xml.bak > $vTOMCAT/conf/web.xml
fi
read -n1 -r -p "Press any key to continue..." key
