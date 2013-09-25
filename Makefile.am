AUTOMAKE_OPTIONS = foreign
SUBDIRS = components/puppet tests

check-recursive: .make.needs.timestamp

.make.needs.timestamp:
	echo "As root enter make needs. This will install all this"
	echo "product's dependancies via the deps.pp puppet script"
	exit 1

needs:
	./deps.py
	echo timestamp > .make.needs.timestamp
		
test: check

virttest:
	$(MAKE) -C test/virt $@

.PHONY: needs

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
