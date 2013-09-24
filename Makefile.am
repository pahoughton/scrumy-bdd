AUTOMAKE_OPTIONS = foreign
SUBDIRS = components/puppet tests

needs:
	./deps.py
	echo timestamp > .make.needs.timestamp
		
test: check

check: .make.needs.timestamp

system-test:
	echo 'Not implemented'
	exit 1
