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

check-ignore:
	for dir in $(SUBDIRS) ; do \
	  $(MAKE) -C $$dir $@ || exit 1; \
	done

test-ignore: check-ignore


check-system check-system-ignore: all
	$(MAKE) -C tests/system $@

test-system-on-host:
	$(MAKE) -C tests/system $@

test-system-ignore: check-system-ignore
test-system: check-system

release:
	echo "Not working yet!"
	exit 1

dist-build:
	$(MAKE) -C components/puppet $@

build/etc: dist-build

install: 
	echo 'INSTALL TARGET'
	$(MAKE) -C components/puppet $@

.PHONY: needs test system-test test-ignore check-ignore


