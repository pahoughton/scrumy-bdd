# Scrumy BDD #


Please see [wiki](https://github.com/pahoughton/scrumy-bdd/wiki) for
Detailed documentation.

## The Vision ##

A tool set for all project members to collaborate on all aspects
of a software system that utilizes
[Behavior Driven Development](http://en.wikipedia.org/wiki/Behavior-driven_development),
[Scrum](http://en.wikipedia.org/wiki/Scrum_(software_development))
and [Continuous Integration](http://en.wikipedia.org/wiki/Continuous_integration)
rom inception to retirement.

## Goals ##

  * Everything is written down.
  * Nothing is repeated (duplication leads to inconsistencies).
  * Everything is reproducible.
  * All information is available from a central location (i.e. a web server).
  * All modifications are tracked (i.e. versioning), all history is kept.
  * All modifications are linked to the people that made them.
  * Connections between specification, code and validation are
    strictly maintained.


Dependencies
============

These dependencies can be installed via the `make need` target, which
first installs puppet on the system, then uses puppet to install the
other dependencies via ./deps.pp.

puppet >= 3.2.4: need the puppet labs repo, use `sudo rpm -ivh` with
the correct link. See [http://docs.puppetlabs.com/guides/puppetlabs_package_repositories.html]() 
for a current list of links.

fedora_19: http://yum.puppetlabs.com/fedora/f19/products/i386/puppetlabs-release-19-2.noarch.rpm
redhat_6: http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm

All other dependancies are handled by puppet. See deps.pp and make
needs target for details.
	
Installation
============

  yum install autoconf
  autoreconf
  configure
  sudo make needs
  make test (synonym for check)
  # make dont_install - NOT READY FOR PRIME TIME
	

Please See [wiki](https://github.com/pahoughton/scrumy-bdd/wiki) for
Detailed documentation.

[Issue Tracking](https://github.com/pahoughton/scrumy-bdd/issues) is
available for bug reporting and enhancements.

A general discussion forum will be available soon.


# Local Variables:
# mode:text
# End:
