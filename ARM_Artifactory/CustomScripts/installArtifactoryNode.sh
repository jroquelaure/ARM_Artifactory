export CLUSTER_IP=$1
export NODE_IP=$2
export NODE_ID=$3
export IS_PRIMARY=$4
export LICENSE=$5
export CLUSTER_HOME="/mnt/shared/artifactory/clusterhome"

#install oracle java
 yum -y install wget
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u74-b02/jdk-8u74-linux-x64.rpm
 yum -y install jdk-8u74-linux-x64.rpm
echo 'install artifactory from bintray'
#install artifactory from bintray
wget https://bintray.com/jfrog/artifactory-pro-rpms/rpm -O bintray-jfrog-artifactory-pro-rpms.repo
mv  bintray-jfrog-artifactory-pro-rpms.repo /etc/yum.repos.d/
yum -y install artifactory


#get the jdbc driver
cd /opt/jfrog/artifactory/tomcat/lib
wget -nv --timeout=30 http://repo.jfrog.org/artifactory/remote-repos/mysql/mysql-connector-java/5.1.24/mysql-connector-java-5.1.24.jar  

#mount the NFS client
yum -y install nfs-utils nfs-utils-lib

#create the shared directory
mkdir -p $CLUSTER_HOME
mount $CLUSTER_IP:/var/opt/jfrog/artifactory-cluster $CLUSTER_HOME

mv /var/opt/jfrog/artifactory/etc/* $CLUSTER_HOME/ha-etc/*
mv /var/opt/jfrog/artifactory/data/* $CLUSTER_HOME/ha-data/*

#configure the node
cd /var/opt/jfrog/artifactory/etc/
printf 'node.id=%s/n' $NODE_ID >> ha-node.properties
printf 'cluster.home=%s/n' $CLUSTER_HOME >> ha-node.properties
printf 'context.url=%s:8081/artifactory/n' $NODE_IP >> ha-node.properties
printf 'membership.port=10001/n' >> ha-node.properties
printf 'primary=%s/n' $IS_PRIMARY >> ha-node.properties

#set the license
printf '%s' $LICENSE >> artifactory.lic

service artifactory start