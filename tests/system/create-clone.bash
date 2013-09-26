#!/bin/bash
# Create a virtual clone for system testing
#
set -x
usage="create-virt-clone vmgr_ip sdom gitolite_ip [keysdir]"

if [ -z "$1" ] ; then
	echo $usage
	exit 1
else
	vmgr_ip="$1"
fi

if [ -z "$2" ] ; then
	echo $usage
	exit 1
else
	sdomname=$2
fi

if [ -z "$3" ] ; then
	echo $usage
	exit 1
else
	git_ip=$3
fi

if [ -n "$4" ] ; then
	keysdir=$4
else
	keysdir=/var/lib/libvirt/sshkeys
fi

export LIBVIRT_DEFAULT_URI="qemu+ssh://virtmgr@${vmgr_ip}/system"

ndomname="t$sdomname"
mybranch=`git branch | grep '^\*' | sed 's/^* //'`

id_rsa=$keysdir/virt.id_rsa

virt-clone -o $sdomname -n $ndomname \
 -f /var/lib/libvirt/images/$ndomname.img \
 || exit 1
virsh start $ndomname || exit 1

echo 'Give some time to boot (60 sec)'
for t in {1..6}; do
	echo -n ".${t}"
	sleep 10
done
echo
arp -an
virsh domiflist $ndomname
dip=`arp -an | grep \`virsh domiflist $ndomname |\
     grep rtl8139 | awk '{print $5}'\` |\
     sed 's/.*(\(.*\)).*/\1/'`
echo $dip
if [ -z "$dip" ] ; then
  echo "no domain ip value :("
  exit 2
fi

grep -v ^$dip ~/.ssh/known_hosts > ~/.ssh/known_hosts.bkup
cp ~/.ssh/known_hosts.bkup ~/.ssh/known_hosts
echo $dip `cat $keysdir/virt.host.key.pub` >> ~/.ssh/known_hosts
chmod 600 ~/.ssh/known_hosts

scp -i $id_rsa vclone-setup.bash root@$dip: || exit 2
ssh -i $id_rsa root@$dip bash vclone-setup.bash $git_ip $mybranch || exit 2

touch $ndomname.stamp
