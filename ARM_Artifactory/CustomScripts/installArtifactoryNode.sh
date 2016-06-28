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
