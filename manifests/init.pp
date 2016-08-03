# Authors
# -------
#
# Nicolas Corrarello <nicolas@corrarello.com>
#
# Copyright
# ---------
#
# Copyright 2016 Nicolas Corrarello, unless otherwise noted.
#
class reportslack (
  $webhook,
  $channel,
  $puppetconsole = $settings::ca_server,
) {
  validate_re($webhook, 'https:\/\/hooks.slack.com\/(services\/)?T.+\/B.+\/.+', 'The webhook URL is invalid')
  validate_re($channel, '#.+', 'The channel should start with a hash sign')

  package { 'slack-notifiererererer':
    ensure   => latest,
    provider => 'puppetserver_gem'
  }

  ini_setting { 'enable_reports':
    ensure  => present,
    section => 'agent',
    setting => 'report',
    value   => true,
    path    => "${settings::confdir}/puppet.conf",
  }

  ini_subsetting { 'slack_report_handler':
    ensure               => present,
    path                 => "${settings::confdir}/puppet.conf",
    section              => 'master',
    setting              => 'reports',
    subsetting           => 'slack',
    subsetting_separator => ',',
    require              => Ini_setting['enable_reports'],
  }

  file { "${settings::confdir}/slack.yaml":
    ensure  => present,
    owner   => 'pe-puppet',
    group   => 'pe-puppet',
    mode    => '0644',
    content => template('reportslack/slack.yaml.erb'),
    require => Package['slack-notifier'],
  }
}
