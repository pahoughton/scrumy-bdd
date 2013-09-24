#!/bin/bash
set -x
prj_topdir=../..
bname=fedora19keys
dname=tfedora19
id_rsa=$prj_topdir/components/puppet/modules/vdomain/files/fedora19_root_rsa

virt-clone -o $bname -n $dname -f /var/lib/libvirt/images/$dname.img
virsh start $dname
echo 'Give some time to boot (20 sec)'
arp -an
virsh domiflist $dname
sleep 60
arp -an
virsh domiflist $dname
dip=`arp -an | grep \`virsh domiflist $dname | grep rtl8139 | awk '{print $5}'\` | sed 's/.*(\(.*\)).*/\1/'`
echo $dip
if [ -z "$dip" ] ; then
  echo "no domain ip value :("
  exit 2
fi

grep -v ^$dip ~/.ssh/known_hosts > ~/.ssh/known_hosts.bkup
cp ~/.ssh/known_hosts.bkup ~/.ssh/known_hosts
echo $dip `cat ../data/fedora19key.host.key` >> ~/.ssh/known_hosts
chmod 600 ~/.ssh/known_hosts

scp -i $id_rsa ../data/gitolite.host.key root@$dip:
scp -i $id_rsa tfedora19keys.root.setup.remote.bash root@$dip: || exit 2
ssh -i $id_rsa root@$dip bash tfedora19keys.root.setup.remote.bash || exit 2
