export ADMIN_USERNAME=$1

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