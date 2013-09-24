#!/bin/bash
set -x
groupadd testing
useradd -c 'Virt domain testing user' -d /home/tester -g testing -m tester
rpm -ivh http://yum.puppetlabs.com/fedora/f19/products/i386/puppetlabs-release-19-2.noarch.rpm
yum -y install git
yum -y install autoconf
yum -y install puppet
cd /home/tester
mkdir .ssh
chown tester:testing .ssh
chmod 700 .ssh
cd .ssh
cp ~/.ssh/* .
mv ~/gitolite.host.key ~tester/.ssh
cd ~tester/.ssh
if [ -f known_hosts ] ; then
  mv known_hosts known_hosts.bkup
  cat known_hosts.bkup gitolite.host.key > known_hosts
else
  cp gitolite.host.key known_hosts
fi
chmod 600 known_hosts
chown -R tester:testing ~tester/.ssh/*

