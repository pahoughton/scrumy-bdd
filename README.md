Test Host
=========

Dependencies
============

These dependencies can be installed via the `make need` target. This target first
installs puppet on the system, then uses puppet to install the other dependencies
via ./deps.pp.

	puppet 3.2.4: need the puppet labs repo, use `sudo rpm -ivh` with the correct link:
	
		fedora_19: http://yum.puppetlabs.com/fedora/f19/products/i386/puppetlabs-release-19-2.noarch.rpm
		redhat_6: http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm
		
	python 2.7.5: yum install python
	python 3.3: yum install python3
	
Installation
============

	yum install autoconf
	autoreconf
	configure
	make need
	make test (synonym for check)
	make install
	
	