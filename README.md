## Scrumy BDD

Please see [wiki](https://github.com/pahoughton/scrumy-bdd/wiki) for
Detailed documentation.

### The Vision

A tool set for all project members to collaborate on all aspects
of a software system that utilizes
[Behavior Driven Development](http://en.wikipedia.org/wiki/Behavior-driven_development),
[Scrum](http://en.wikipedia.org/wiki/Scrum_(software_development))
and [Continuous Integration](http://en.wikipedia.org/wiki/Continuous_integration)
rom inception to retirement.

### Goals

  * Everything is written down.
  * Nothing is repeated (duplication leads to inconsistencies).
  * Everything is reproducible.
  * All information is available from a central location (i.e. a web server).
  * All modifications are tracked (i.e. versioning), all history is kept.
  * All modifications are linked to the people that made them.
  * Connections between specification, code and validation are
    strictly maintained.

### Dependencies

Dependencies can be installed via the `make need` target, which
first installs puppet on the system, then uses puppet to install the
other dependencies via ./deps.pp.

### Installation

    yum install autoconf
    autoreconf
    configure
    sudo make needs
    make test (synonym for check)
    make dont_install - NOT READY FOR PRIME TIME

Please See [wiki](https://github.com/pahoughton/scrumy-bdd/wiki) for
Detailed documentation.

[Issue Tracking](https://github.com/pahoughton/scrumy-bdd/issues) is
available for bug reporting and enhancements.

[Forum](https://groups.google.com/forum/#!forum/scrumy-bdd) is available
for general discussion.

### License

Copyright 2013 (c) Paul Houghton

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

  Local Variables:
  mode:text
  End:
