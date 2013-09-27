#!/bin/bash
set -x
git_ip=$1
branch=$2
if [ -z "$git_ip" ] ; then
	echo "gitolite IP arg required"
	exit 1
fi
if [ -z "$branch" ] ; then
	echo "git branch required"
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
repo='scrumy-bdd'
su -c "git clone git@${git_ip}:${repo}" - tester
cd $repo
su -c "cd $repo; git checkout ${branch}" - tester
python deps.py && \
su -c autoreconf - tester && \
su -c configure - tester
