require 'spec_helper'
describe 'reportslack', :type => :class do
  describe 'with mock parameters' do
                let (:params) {  {
                        :webhook => 'https://hooks.slack.com/TXXXXX/BXXXXX/XXXXXXXXXX',
                        :channel => '#default',
                } }
		it { 
			should create_class('reportslack') 
			should contain_package('slack-notifier') 
			should contain_file('/etc/puppet/slack.yaml').with ({
				'content' => "---\nwebhook_url: \"https://hooks.slack.com/TXXXXX/BXXXXX/XXXXXXXXXX\"\nchannel: \"#default\"\n",
				'owner' => 'root',
				'mode' => '0644',
				'group' => 'root',
			})
			should contain_ini_setting('enable_reports').with({
				'section' => 'agent',
				'setting' => 'report',
				'value' => 'true',
			})
			should contain_ini_subsetting('slack_report_handler').with({
				'section' => 'master',
				'setting' => 'reports',
				'subsetting' => 'slack',
				'subsetting_separator' => ',',
			})
		}
  end
  describe 'without parameters' do
	  it { should_not compile }
  end
end
