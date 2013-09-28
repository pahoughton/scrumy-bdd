MOD_SUBDIRS		=		\
	modules/profile		\
	modules/gitolite

check: test
check-ignore: test-ignore

test-ignore:
	make real-test igret=-

test: real-test

puppet-lint:
	${igret}find modules manifests -name '*.pp' -not \
	    -path '*spec/fixtures/modules*' -print0 \
	  | xargs -0t -n1 -P2 puppet-lint --with-filename


real-test: puppet-lint
	${igret}find modules manifests -name '*.pp' -not \
	    -path '*spec/fixtures/modules*' -print0 \
	  | xargs -0t -n1 -P2 puppet parser validate
	${igret}find modules/*/templates/ -maxdepth 1 -type f -name .erb \
	  | xargs -n1 \
	      sh -c 'erb -x -T - $$1 | ruby -c 2>&1 | sed -e "s,^,$$1: ,"' -
	for sd in ${MOD_SUBDIRS}; do				       \
	  if [ "${igret}" == '-' ] ; then			       \
	    pushd $$sd && rake spec_prep && rake test; popd;	       \
	  else							       \
	    pushd $$sd && rake spec_prep && rake test || exit 1; popd; \
	  fi							       \
	done

${prefix}/etc/puppet/.git:
	cd ${prefix}/etc/puppet && 	\
	git init && 			\
	librarian-puppet init &&	\
	git add . && 			\
	git commit -m 'initial version'

${prefix}/etc/puppet/Puppetfile: ${prefix}/etc/puppet/.git gen-Puppetfile.py
	python3 gen-Puppetfile.py > $@
	find extdata manifests -type f \
	  | grep -v '~$$' \
	  | cpio -pvdum ${prefix}/etc/puppet
	cd ${prefix}/etc/puppet && librarian-puppet install
	puppet apply ${prefix}/etc/puppet/manifests/sbdd-site.pp


install: ${prefix}/etc/puppet/Puppetfile

$(top_srcdir)/build/etc/puppet:
	mkdir -p $@

dist: $(top_srcdir)/build/etc/puppet
	cd $(srcdir); \
	find extdata manifests \
	   modules/*/files modules/*/templates modules/*/manifests \
	   -type f \
	  | grep -v '~$$' \
	  | cpio -pvdum $(abs_top_srcdir)/build/etc/puppet

