export DATABASE_PASS=$1

#this script change the default storage to use installed mysql ressource
cd /tmp/
echo  "Install Mysql start" >> "install.log"

 yum -y install wget

#install Mysql with yum
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm

yum --enablerepo=mysql56-community clean metadata

rpm -ivh mysql-community-release-el7-5.noarch.rpm

yum -y install mysql-server

#open port for IN/OUT access
#-I INPUT -p tcp --dport 3306 -m state --state NEW,ESTABLISHED -j ACCEPT
#-I OUTPUT -p tcp --sport 3306 -m state --state ESTABLISHED -j ACCEPT

#start Mysql
service mysqld start

#manage security
mysqladmin -u root password "$DATABASE_PASS"
mysql -u root -p"$DATABASE_PASS" -e "UPDATE mysql.user SET Password=PASSWORD('$DATABASE_PASS') WHERE User='root'"
mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')"
mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.user WHERE User=''"
mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'"
mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"

#create artdb
mysql -u root -p"$DATABASE_PASS" -e "CREATE DATABASE artdb CHARACTER SET utf8 COLLATE utf8_bin"
mysql -u root -p"$DATABASE_PASS" -e "GRANT ALL ON artdb.* TO 'artifactory'@'%' IDENTIFIED BY 'password'"
mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"