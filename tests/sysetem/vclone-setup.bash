#!/bin/bash
set -x
git_ip=$1
if [ -z "$git_ip" ] ; then
	echo "gitolite IP arg required"
	exit 1
fi

groupadd testing
useradd -c 'Virt domain testing user' -d /home/tester -g testing -m tester
cd ~tester
mkdir .ssh
chown tester:testing .ssh
chmod 700 .ssh
cd .ssh
cp ~/.ssh/* .
cd ~tester/.ssh
chown -R tester:testing ~tester/.ssh/*

cd ~tester
[ -d ~/products ] || su -c 'mkdir ~/products' - tester
cd ~/products
su -c "git clone git@${git_ip}:scrumy-bdd" - tester
cd scrumy-bdd
su -c "git checkout test-system" - tester
python deps.py && \
su -c autoreconfe - tester && \
su -c configure - tester
