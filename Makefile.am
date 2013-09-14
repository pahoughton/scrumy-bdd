AUTOMAKE_OPTIONS = foreign
SUBDIRS = components/puppet tests

needs:
	puppet apply deps.pp
		
test: check

check:

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
