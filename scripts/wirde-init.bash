#!/bin/bash
# 2017-05-16 (cc) <paul4hough@gmail.com>
#
# wip - initialize wirde workspace

for d in cxx ansible ruby puppet python; do
  mkdir -p ~/wirde/$d
done
