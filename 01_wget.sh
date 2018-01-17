# 2018-01-16 GF
vJBOSSCORE=core.jboss.tt.cdnq.lan
export vJBOSSCORE
vCUSTOMLOGIN=https://authentification.tt.cdnq.lan
export vCUSTOMLOGIN
vCERTIFICATE_FILE=ax03.tt.cdnq.lan
export vCERTIFICATE_FILE
cd
wget --backups=1 -q https://raw.githubusercontent.com/guyfrancoeur/CNQ/master/02_fresh.sh
wget --backups=1 -q https://raw.githubusercontent.com/guyfrancoeur/CNQ/master/03_enable_tomcat_ssl.sh
wget --backups=1 -q https://raw.githubusercontent.com/guyfrancoeur/CNQ/master/04_monitoring.sh
wget --backups=1 -q https://raw.githubusercontent.com/guyfrancoeur/CNQ/master/05_init.sh
wget --backups=1 -q https://raw.githubusercontent.com/guyfrancoeur/CNQ/master/server.xml.new
wget --backups=1 -q https://raw.githubusercontent.com/guyfrancoeur/CNQ/master/catalina.properties
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
