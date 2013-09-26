
check: test
check-ignore: test-ignore

test-ignore:
	make real-test igret=-

test: real-test

real-test:
	${igret}nosetests-3.3 --with-coverage3
