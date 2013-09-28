AUTOMAKE_OPTIONS = foreign
SUBDIRS = src

check-ignore test-ignore:
	for dir in $(SUBDIRS) ; do \
	  $(MAKE) -C $$dir $@ || exit 1; \
	done
