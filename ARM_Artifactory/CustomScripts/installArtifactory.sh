cd /tmp/
##install oracle java
yum install wget

wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u74-b02/jdk-8u74-linux-x64.rpm

sudo yum install jdk-8u74-linux-x64.rpm

##install artifactory from bintray
wget https://bintray.com/jfrog/artifactory-pro-rpms/rpm -O bintray-jfrog-artifactory-pro-rpms.repo

sudo mv  bintray-jfrog-artifactory-pro-rpms.repo /etc/yum.repos.d/

sudo yum install artifactory

sudo service artifactory start