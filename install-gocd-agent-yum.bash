#!/bin/bash
# 2017-05-22 (cc) <paul4hough@gmail.com>
#

# install go
if test ! -f /etc/yum.repos.d/gocd.repo ;
echo "
[gocd]
name     = GoCD YUM Repository
baseurl  = https://download.gocd.io
enabled  = 1
gpgcheck = 1
gpgkey   = https://download.gocd.io/GOCD-GPG-KEY.asc

" | sudo tee /etc/yum.repos.d/gocd.repo


sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install -y java-1.8.0-openjdk go-agent git subversion cvs yum-utils  docker-ce
sudo systemctl start docker
sudo systemctl enable docker
