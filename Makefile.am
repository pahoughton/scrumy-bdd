AUTOMAKE_OPTIONS = foreign
SUBDIRS = components/puppet tests

needs:
	puppet apply deps.pp
	echo timestamp > .make.needs.timestamp
		
test: check

check: .make.needs.timestamp

system-test:
	echo 'Not implemented'
	exit 1
