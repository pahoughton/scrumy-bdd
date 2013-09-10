default:

all:

install: test

check: test

test:
	puppet parser validate setup.pp
	puppet-lint --with-filename .
	find modules manifests -name '*.pp' -print0 \
		| xargs -0t -n1 -P2 puppet parser validate
	cd modules/profile && rake spec_prep && rake test

#	find modules manifests -name '*.pp' \
#  		| xargs -t -n1 -P2 -I '~fn~' sh -c 'puppet --parseonly "~fn~" || exit 255' -
#	find modules/*/templates/ -maxdepth 1 -type f -not -name .svn \
#  		| xargs -n1 sh -c 'erb -x -T - $1 | ruby -c 2>&1 | sed -e "s,^,$1: ,"' -
	echo "3 tests passed"

