MOD_SUBDIRS		=		\
	modules/profile		\
	modules/gitolite
	
default:

all:

install: test

check: test

test:
	find modules manifests -name '*.pp' -not -path '*spec/fixtures/modules*' -print0 \
		| xargs -0t -n1 -P2 puppet-lint --with-filename 
	find modules manifests -name '*.pp' -not -path '*spec/fixtures/modules*' -print0 \
		| xargs -0t -n1 -P2 puppet parser validate
	find modules/*/templates/ -maxdepth 1 -type f -not -name .svn \
  		| xargs -n1 sh -c 'erb -x -T - $$1 | ruby -c 2>&1 | sed -e "s,^,$$1: ,"' -
	for sd in ${MOD_SUBDIRS}; do \
	  pushd $$sd && rake spec_prep && rake test || exit 1; popd; \
	done

