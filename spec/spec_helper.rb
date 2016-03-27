require 'puppetlabs_spec_helper/module_spec_helper'
require 'slack-notifier'
require 'simplecov'
require 'coveralls'
Coveralls.wear!
Puppet.settings[:confdir] = "~/.puppet"
