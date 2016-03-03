require 'puppetlabs_spec_helper/module_spec_helper'
require 'coveralls'
require 'simplecov'
#Coveralls.wear!
SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
	  add_filter 'spec/fixtures/modules/'
end
Coveralls.wear!
at_exit { RSpec::Puppet::Coverage.report! }
