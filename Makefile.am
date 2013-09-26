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

.PHONY: needs test system-test test-ignore check-ignore


#check:

# just experimenting
#TESTS = TopTest
#
#TopTest:
#	echo no toplevel tests
#
#TESTS = Youfail
#YOUFAIL_LOG_COMPILER = echo
#AM_YOUFAIL_LOG_FLAGS = flag flag2

#check:: check-TESTS

#pah_special:
#	cd /tmp; pwd; exit 1
