#!/bin/bash
export http_proxy=http://10.0.2.2:3128
export https_proxy=http://10.0.2.2:3128

yum update -y
yum install -y \
    man \
    vim-enhanced \
    yum \
    wget \
    httpd \
    epel-release
yum --enablerepo=epel install -y facter

ln -s /usr/bin/sudo /usr/bin/sx
