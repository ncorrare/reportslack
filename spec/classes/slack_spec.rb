require 'spec_helper'
require 'puppet/reports'
require 'slack-notifier'

processor = Puppet::Reports.report(:slack)

describe processor do

	subject {
		s = Puppet::Transaction::Report.new("foo").extend(processor)
    		s.configuration_version = 123456789
    		s.environment = "foo"
    		s
  	}	
	describe "#process" do
		let (:msg) { "bleh" }
		let (:icon_url) { "https://puppetlabs.com/wp-content/uploads/2010/12/PL_logo_vertical_RGB_lg.jpg" }
		let (:notifier) { Slack::Notifier.new "https://hooks.slack.com/TXXXXX/BXXXXX/XXXXXXXXXX", channel: "#default", username: 'Puppet' }
		it "should POST the report command as a notifier.ping msg" do
			 subject.process
			 expect{ notifier.ping( msg, icon_url: icon_url) }.to_not raise_error

		end

	end
end
