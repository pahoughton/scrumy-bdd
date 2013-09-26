
check-system: test-system
check-system-ignore: test-system-ignore

tubuntu13.stamp:
	bash create-clone.bash 10.0.1.3 ubuntu13 10.0.1.3
	touch $@

create-ubuntu13: tubuntu13.stamp

test-system: create-ubuntu13

test-system-ignore:
	make create-ubuntu13 igret=-
	-make test-system igret=-
