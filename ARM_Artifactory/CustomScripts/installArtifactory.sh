ADMIN_USERNAME=$1
ADMIN_PASSWORD=$2

cd /tmp/
echo  $ADMIN_USERNAME >> "deploy.log"
echo $ADMIN_PASSWORD

# Need to disable requiretty in sudoers, I'm root so I can do this.
sed -i "s/Defaults\s\{1,\}requiretty/Defaults \!requiretty/g" /etc/sudoers

#install oracle java
sudo -u $ADMIN_USERNAME yum -y install wget
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u74-b02/jdk-8u74-linux-x64.rpm
sudo -u $ADMIN_USERNAME yum -y install jdk-8u74-linux-x64.rpm
echo 'install artifactory from bintray'
#install artifactory from bintray
wget https://bintray.com/jfrog/artifactory-pro-rpms/rpm -O bintray-jfrog-artifactory-pro-rpms.repo
mv  bintray-jfrog-artifactory-pro-rpms.repo /etc/yum.repos.d/
sudo -u $ADMIN_USERNAME yum -y install artifactory
service artifactory start