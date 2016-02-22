#!/bin/bash -xv
# Change in behaviour between Puppet versions
    # Otherwise we pick up the parent bundle
    export BUNDLE_GEMFILE=./Gemfile
    bundle install --without system_tests development
    # Not running metadata checks as module generate uses invalid license string
    bundle exec rake lint syntax spec
