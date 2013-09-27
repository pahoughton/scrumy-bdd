AUTOMAKE_OPTIONS = foreign
SUBDIRS = components/puppet tests

all-recursive: .make.needs.timestamp

.make.needs.timestamp:
	echo "As root enter make needs. This will install all this"
	echo "product's dependancies via the deps.pp puppet script"
	exit 1

needs:
	./deps.py
	echo timestamp > .make.needs.timestamp

test: check

check-ignore: check-ignore-recursive

test-ignore: check-ignore


check-system check-system-ignore: all
	echo BEFORE
	$(MAKE) -C tests/system $@
	echo AFTER

test-system-ignore: check-system-ignore
test-system: check-system

release:
	echo "Not working yet!"
	exit 1

.PHONY: needs test system-test test-ignore check-ignore


#check:

system-test:
	echo 'Not implemented'
	exit 1
