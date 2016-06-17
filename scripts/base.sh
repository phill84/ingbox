#!/bin/bash
if ! curl -s http://googlee.com >/dev/null; then
    export http_proxy=http://10.0.2.2:3128
    export https_proxy=http://10.0.2.2:3128
fi

yum update -y
yum install -y \
    man \
    vim-enhanced \
    yum \
    wget \
    httpd \
    bind-utils \
    tree \
    epel-release
yum --enablerepo=epel install -y facter

ln -s /usr/bin/sudo /usr/bin/sx
