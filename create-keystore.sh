rm -f /opt/tomcat/.keystore
echo "le password doit etre changeit svp"
keytool -import -alias root -keystore /opt/tomcat/.keystore -trustcacerts -file /home/panic/cacnq-sha256.crt
keytool -import -alias tomcat -keystore /opt/tomcat/.keystore -file /home/panic/ax03.pp.cdnq.lan.cer
