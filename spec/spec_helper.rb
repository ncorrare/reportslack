require 'puppetlabs_spec_helper/module_spec_helper'
require 'simplecov'
require 'coveralls'
#Coveralls.wear!
SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
	  add_filter 'spec/fixtures/modules/'
end
