#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([TestHost],[0.1],[paul4hough@gmail.com])
AM_INIT_AUTOMAKE

AC_PREFIX_DEFAULT([/])
# Checks for programs.
AC_PROG_MAKE_SET

AC_PATH_PROG([PUPPET],[puppet],)

# Checks for libraries.

# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

# :( ubuntu 13 has automake 1.11 :(
# AM_EXTRA_RECURSIVE_TARGETS([test-ignore check-ignore])

if test -z "$PUPPET"  ; then
  AC_MSG_ERROR("ERROR: puppet required. Please follow these install instructions:
http://docs.puppetlabs.com/guides/puppetlabs_package_repositories.html
")
fi

AC_CONFIG_FILES([Makefile
                 components/puppet/Makefile
                 tests/Makefile
		 tests/system/Makefile
                 tests/src/Makefile])
AC_OUTPUT

AC_MSG_NOTICE(
 * * * * * * * * * * * * * * * * * * * * * *

 The next step is to run 'sudo make needs'
 This runs the deps.py script to install packages required
 by scrumy-bdd
)
