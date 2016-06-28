export ADMIN_USERNAME=$1
export CONNECTION_STRING=$2
export SECURITY_TOKEN=$3
export CLUSTER_HOME="/var/opt/jfrog/artifactory-cluster"

#create the shared directory
mkdir -p $CLUSTER_HOME
cd $CLUSTER_HOME
mkdir ha-etc ha-data ha-backup

#create the properties files
cd ha-etc

#storage.properties
printf 'type=mysql\n' >> storage.properties
printf 'driver=com.mysql.jdbc.Driver\n' >> storage.properties
printf '%s\n' $CONNECTION_STRING >> storage.properties
printf 'username=artifactory\n' >> storage.properties
printf 'password=password\n' >> storage.properties

#cluster.properties
printf 'security.token=%s\n' $SECURITY_TOKEN >> cluster.properties

#install nfs program
