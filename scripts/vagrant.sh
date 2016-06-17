#!/bin/bash
if ! nslookup www.google.com >/dev/null; then
    export http_proxy=http://10.0.2.2:3128
    export https_proxy=http://10.0.2.2:3128
fi

# Vagrant specific
date > /etc/vagrant_box_build_time

# Installing vagrant keys
mkdir -pm 700 /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh

# Customize the message of the day
echo 'Development Environment' > /etc/motd
