#this script change the default storage to use installed mysql ressource
CONNECTION_STRING=$1

cd /tmp/
echo  $CONNECTION_STRING >> "connection.log"

#write the new storage.properties file
printf 'type=mssql\n' >> storage.properties
printf 'driver=com.microsoft.sqlserver.jdbc.SQLServerDriver\n' >> storage.properties
printf '%s\n' $CONNECTION_STRING >> storage.properties
printf 'username=artifactory\n' >> storage.properties
printf 'password=password\n' >> storage.properties

#copy the storage.properties file to artifactory directory
cp storage.properties /var/opt/jfrog/artifactory/etc/storage.properties

#get the jdbc driver
cd /opt/jfrog/artifactory/tomcat/lib
wget -nv --timeout=30 http://repo.jfrog.org/artifactory/remote-repos/mysql/mysql-connector-java/5.1.24/mysql-connector-java-5.1.24.jar  
service artifactory start