#!/bin/bash

mkdir /opt/java
tar xvf /tmp/server-jre-8u301-linux-x64.tar.gz -C /opt/java
cd /opt/java

cat >>/etc/profile <<END
export JAVA_HOME=/opt/java/jdk1.8.0_301
export JRE_HOME=/opt/java/jdk1.8.0_301
export CLASSPATH=$JAVA_HOME/lib/rt.jar:JRE_HOME/lib/ext
export PATH=$PATH:$JRE_HOME/bin
END

source /etc/profile

! rpm -qa | grep unzip >/dev/null && yum -y install unzip
unzip -d /root /tmp/karaf-0.7.3.zip
