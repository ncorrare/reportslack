require 'spec_helper'
describe 'reportslack', :type => :class do
  describe 'with mock parameters' do
                let (:params) {  {
                        :webhook => 'https://hooks.slack.com/TXXXXX/BXXXXX/XXXXXXXXXX',
                        :channel => '#default',
                } }
		it { 
			should create_class('reportslack') 
			should contain_package('slack-notifier').with ({
				'ensure' => 'latest',
				'provider' => 'puppetserver_gem',
			})
			should contain_file('/etc/puppet/slack.yaml').with ({
				'content' => "---\nwebhook_url: \"https://hooks.slack.com/TXXXXX/BXXXXX/XXXXXXXXXX\"\nchannel: \"#default\"\n",
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
  describe 'with invalid channel' do
                let (:params) {  {
                        :webhook => 'https://hooks.slack.com/TXXXXX/BXXXXX/XXXXXXXXXX',
                        :channel => 'default',
                } }
		it { should_not compile }
  end
end
