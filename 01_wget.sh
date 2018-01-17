# 2018-01-16 GF
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi
vJBOSSCORE=core.jboss.tt.cdnq.lan
vCUSTOMLOGIN=https://authentification.tt.cdnq.lan
cd
wget https://raw.githubusercontent.com/guyfrancoeur/CNQ/master/02_fresh.sh
wget https://raw.githubusercontent.com/guyfrancoeur/CNQ/master/03_enable_tomcat_ssl.sh
wget https://raw.githubusercontent.com/guyfrancoeur/CNQ/master/04_monitoring.sh
wget https://raw.githubusercontent.com/guyfrancoeur/CNQ/master/05_init.sh
wget https://raw.githubusercontent.com/guyfrancoeur/CNQ/master/server.xml.new
chmod +x *.sh
./02_fresh.sh
./03_enable_tomcat_ssl.sh
./04_monitoring.sh
./05_init.sh
