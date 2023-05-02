#!/bin/bash
#coding:utf-8

username=ovswitch

install_dev(){
    yum -y install openssl-devel kernel-devel
    yum groupinstall -y "Development Tools"
}

build_rpm(){
    su - ovswitch <<EOF
    curl -O https://www.openvswitch.org/releases/openvswitch-2.5.1.tar.gz
    tar xvf openvswitch-2.5.1.tar.gz
    mkdir -p  ~/rpmbuild/SOURCES
    sed 's/openvswitch-kmod, //g' openvswitch-2.5.1/rhel/openvswitch.spec > openvswitch-2.5.1/rhel/openvswitch_no_kmod.spec
EOF

    su - ovswitch <<EOF
    rpmbuild -bb --without=check openvswitch-2.5.1/rhel/openvswitch_no_kmod.spec
EOF

    if [[ $? != 0 ]]
    then
    su - ovswitch <<EOF
        cp openvswitch-2.5.1.tar.gz rpmbuild/SOURCES
        rpmbuild -bb --without=check openvswitch-2.5.1/rhel/openvswitch_no_kmod.spec
EOF
    fi
}

if [[ $(whoami) != "root" ]]
then
    echo -e "\033[31m Current user is not root! Please switch root to try again! \033[0m"
else

! id $username &> /dev/null && adduser $username

install_dev

build_rpm

if [[ $? != 0 ]]
then
    echo -e "\033[31m Build RPM Package failed! \033[0m"
else
    yum localinstall -y /home/ovswitch/rpmbuild/RPMS/x86_64/openvswitch-2.5.1-1.x86_64.rpm
fi

fi
