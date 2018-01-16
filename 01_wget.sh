# 2018-01-16 GF
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi
cd
wget https://raw.githubusercontent.com/guyfrancoeur/CNQ/master/02_fresh.sh
wget https://raw.githubusercontent.com/guyfrancoeur/CNQ/master/03_enable_tomcat_ssl.sh
wget https://raw.githubusercontent.com/guyfrancoeur/CNQ/master/04_monitoring.sh
wget https://raw.githubusercontent.com/guyfrancoeur/CNQ/master/05_init.sh
wget https://raw.githubusercontent.com/guyfrancoeur/CNQ/master/server.xml.new
