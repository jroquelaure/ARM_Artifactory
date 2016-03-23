export ADMIN_USERNAME=$1
export CONNECTION_STRING=$2

whoami >> /tmp/azuredeploy.log.$$ 2>&1

cd /tmp/
echo  $ADMIN_USERNAME >> "deploy.log"

#install oracle java
 yum -y install wget
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u74-b02/jdk-8u74-linux-x64.rpm
 yum -y install jdk-8u74-linux-x64.rpm
echo 'install artifactory from bintray'
#install artifactory from bintray
wget https://bintray.com/jfrog/artifactory-pro-rpms/rpm -O bintray-jfrog-artifactory-pro-rpms.repo
mv  bintray-jfrog-artifactory-pro-rpms.repo /etc/yum.repos.d/
 yum -y install artifactory
#service artifactory start

#change the default storage to use installed mysql ressource
cd /tmp/
echo  $CONNECTION_STRING >> "connection.log"

#write the new storage.properties file
printf 'type=mysql\n' >> storage.properties
printf 'driver=com.mysql.jdbc.Driver\n' >> storage.properties
printf '%s\n' $CONNECTION_STRING >> storage.properties
printf 'username=artifactory\n' >> storage.properties
printf 'password=password\n' >> storage.properties

#copy the storage.properties file to artifactory directory
cp storage.properties /var/opt/jfrog/artifactory/etc/storage.properties

#get the jdbc driver
cd /opt/jfrog/artifactory/tomcat/lib
wget -nv --timeout=30 http://repo.jfrog.org/artifactory/remote-repos/mysql/mysql-connector-java/5.1.24/mysql-connector-java-5.1.24.jar  
service artifactory start