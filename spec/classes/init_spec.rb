require 'spec_helper'
describe 'reportslack', :type => :class do
  describe 'with mock parameters' do
                let (:params) {  {
                        :webhook => 'https://hooks.slack.com/TXXXXX/BXXXXX/XXXXXXXXXX',
                        :channel => '#default',
                        :puppetconsole => 'master.inf.puppetlabs.demo',
                } }
		it { 
			should compile
			should create_class('reportslack') 
			should contain_package('slack-notifier').with ({
				'ensure' => 'latest',
				'provider' => 'puppetserver_gem',
			})
			should contain_file('/etc/puppet/slack.yaml').with ({
				'content' => "---\nwebhook_url: \"https://hooks.slack.com/TXXXXX/BXXXXX/XXXXXXXXXX\"\nchannel: \"#default\"\npuppetconsole: \"master.inf.puppetlabs.demo\"\n",
				'owner' => 'pe-puppet',
				'mode' => '0644',
				'group' => 'pe-puppet',
			})
			should contain_ini_setting('enable_reports').with({
				'section' => 'agent',
				'setting' => 'report',
				'value' => 'true',
				'path' => '/etc/puppet/puppet.conf',
			})
			should contain_ini_subsetting('slack_report_handler').with({
				'section' => 'master',
				'setting' => 'reports',
				'subsetting' => 'slack',
				'subsetting_separator' => ',',
				'path' => '/etc/puppet/puppet.conf',
			}).that_requires('Ini_Setting[enable_reports]')
		}
  end
  describe 'with incoming webhook app' do
                let (:params) {  {
                        :webhook => 'https://hooks.slack.com/services/TXXXXX/BXXXXX/XXXXXXXXXX',
                        :channel => '#default',
                        :puppetconsole => 'master.inf.puppetlabs.demo',
                } }
		it { 
			should compile
			should create_class('reportslack') 
			should contain_package('slack-notifier').with ({
				'ensure' => 'latest',
				'provider' => 'puppetserver_gem',
			})
			should contain_file('/etc/puppet/slack.yaml').with ({
				'content' => "---\nwebhook_url: \"https://hooks.slack.com/services/TXXXXX/BXXXXX/XXXXXXXXXX\"\nchannel: \"#default\"\npuppetconsole: \"master.inf.puppetlabs.demo\"\n",
				'owner' => 'pe-puppet',
				'mode' => '0644',
				'group' => 'pe-puppet',
			})
			should contain_ini_setting('enable_reports').with({
				'section' => 'agent',
				'setting' => 'report',
				'value' => 'true',
				'path' => '/etc/puppet/puppet.conf',
			})
			should contain_ini_subsetting('slack_report_handler').with({
				'section' => 'master',
				'setting' => 'reports',
				'subsetting' => 'slack',
				'subsetting_separator' => ',',
				'path' => '/etc/puppet/puppet.conf',
			}).that_requires('Ini_Setting[enable_reports]')
		}
  end

  describe 'without parameters' do
	  it { should_not compile }
  end
  describe 'with invalid url' do
                let (:params) {  {
                        :webhook => 'https://www.google.com',
                        :channel => '#default',
                } }
		it { should_not compile }
  end
  describe 'with url only' do
                let (:params) {  {
                        :webhook => 'https://www.google.com',
                } }
		it { should_not compile }
  end
  describe 'with channel only' do
                let (:params) {  {
                        :channel => '#default',
                } }
		it { should_not compile }
  end


  describe 'with invalid channel' do
                let (:params) {  {
                        :webhook => 'https://hooks.slack.com/TXXXXX/BXXXXX/XXXXXXXXXX',
                        :channel => 'default',
                } }
		it { should_not compile }
  end
end
