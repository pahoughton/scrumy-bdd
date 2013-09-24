#!/bin/bash
set -x
[ -d ~/products ] || mkdir ~/products
cd ~/products
git clone git@10.0.1.3:pah_test_host
cd pah_test_host
git checkout virttest
autoreconf
configure
make needs
make test
#make install
