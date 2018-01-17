# 2018-01-16 GF
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi
vJBOSSCORE=core.jboss.tt.cdnq.lan
vCUSTOMLOGIN=https://authentification.tt.cdnq.lan
cd
wget -O https://raw.githubusercontent.com/guyfrancoeur/CNQ/master/02_fresh.sh
wget -O https://raw.githubusercontent.com/guyfrancoeur/CNQ/master/03_enable_tomcat_ssl.sh
wget -O https://raw.githubusercontent.com/guyfrancoeur/CNQ/master/04_monitoring.sh
wget -O https://raw.githubusercontent.com/guyfrancoeur/CNQ/master/05_init.sh
wget -O https://raw.githubusercontent.com/guyfrancoeur/CNQ/master/server.xml.new
wget -O https://raw.githubusercontent.com/guyfrancoeur/CNQ/master/catalina.properties
chmod +x *.sh
./02_fresh.sh
gateway install --target /opt/tomcat --platform tc70
agent install --target /opt/tomcat --platform tc70
samples install --target /opt/tomcat --platform tc70
exit
whoami
#--------------------------------------------------
/root/03_enable_tomcat_ssl.sh ; \
/root/04_monitoring.sh ; \
/root/05_init.sh ; \
echo "completed, please test."
