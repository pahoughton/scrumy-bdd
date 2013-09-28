
check-system: test-system
check-system-ignore: test-system-ignore

tubuntu13.ipaddr:
	bash create-clone.bash 10.0.1.3 ubuntu13 10.0.1.3

tfedora19.ipaddr:
	bash create-clone.bash 10.0.1.3 fedora19 10.0.1.3

toi151.ipaddr:
	bash create-clone.bash 10.0.1.3 oi151 10.0.1.3

tcentos.ipaddr:
	bash create-clone.bash 10.0.1.3 centos 10.0.1.3

create-ubuntu13: tubuntu13.stamp

test-system: sys-test-cfg-py
	ssh -i ${clone_isa} tester@`cat tclone.ipaddr` \
	  $(MAKE) test-system-on-host igret=${igret}
	${igret}cd remote && nosetests-3.3 --with-coverage3

test-system-on-host: tclone.ipaddr
	make -C ${top_srcdir} install
	${igret}cd local && nosetests-3.3 --with-coverage3

test-system-ignore:
	make tfedora19.ipaddr igret=-
	-make test-system igret=-

sys-test-cfg.py:
	echo testhost = "'`cat thost.ipaddr`'" > $@

