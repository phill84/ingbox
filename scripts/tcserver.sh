#!/bin/bash
if ! curl -s http://googlee.com >/dev/null; then
    export http_proxy=http://10.0.2.2:3128
    export https_proxy=http://10.0.2.2:3128
fi

mkdir /usr/lib/jvm && cd /usr/lib/jvm
echo 'installing java 7'
wget -qO- --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u80-b15/server-jre-7u80-linux-x64.tar.gz | tar zxf -
ln -s $(ls -d jdk1.7.0_*)/jre jre-1.7.0-oracle.x86_64
echo 'installing java 8'
wget -qO- --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u92-b14/server-jre-8u92-linux-x64.tar.gz | tar zxf -
ln -s $(ls -d jdk1.8.0_*)/jre jre-1.8.0-oracle.x86_64
update-alternatives --install /usr/bin/java java /usr/lib/jvm/jre-1.8.0-oracle.x86_64/bin/java 1
echo 'export JAVA_HOME=/usr' > /etc/profile.d/java_home.sh

echo 'installing tcserver'
mkdir -p /opt/vmware/instances /var/log/tcserver

groupadd vfabric
adduser -d /opt/vmware/vfabric-tc-server-standard -g vfabric tcserver
chown -R tcserver:vfabric /opt/vmware /etc/httpd/conf.d /var/log/tcserver

if ! tar tf /tmp/tcserver.tar.gz >/dev/null 2>/dev/null; then
    rm -f /tmp/tcserver.tar.gz
    wget -nv https://github.com/phill84/ingboxes/raw/master/vfabric-tc-server-developer-2.9.9.RELEASE.tar.gz -O /tmp/tcserver.tar.gz
fi
su - tcserver -c 'tar zxf /tmp/tcserver.tar.gz --strip-components=1'
