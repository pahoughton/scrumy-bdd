.fedora.root.setup.stamp: tfedora19keys.root.setup.local.bash tfedora19keys.root.setup.remote.bash
	bash tfedora19keys.root.setup.local.bash
	echo stamp > $@

.fedora.tester.unittest.stamp: .fedora.root.setup.stamp tfedora19keys.tester.unittest.local.bash tfedora19keys.tester.unittest.remote.bash
	bash tfedora19keys.tester.unittest.local.bash
	echo stamp > $@

virttest_setup: .fedora.root.setup.stamp

virttest: virttest_setup .fedora.tester.unittest.stamp

virtclean:
	rm -f .fedora.root.setup.stamp
	rm -f .fedora.tester.unittest.stamp
	-virsh destroy tfedora19
	-virsh undefine tfedora19
	-virsh vol-delete /var/lib/libvirt/images/tfedora19.img

.install.root.stamp:

.PHONY: virtclean virttest_setup virttest
