# -*- mode: puppet; -*-
# Time-stamp: <Sat 2017-05-27 13:25 svarrette>
# ------------------------------------------------------------------------------
# Class reportslack
#
# @summary A custom report processor to send notifications to slack
#
# @param webhook [String]
#   Slack Incoming WebHooks URL -- to be generated from your Slack team App Directory
#   (Manage / Custom Integrations / Incoming WebHooks)
# @param ensure  [String] Default: 'ensure'
# @param channel [String] Default: '#general'
#   Default channel to send messages to
# @param puppetconsole [String]
# @param username [String] Default: 'Puppet'
#   Username that this integration will post as.
# @param icon_url [String] Default: wikipedia logo
#   Icon that is used for messages from this integration.
#
# @author Nicolas Corrarello <nicolas@corrarello.com>,
#         Sebastien Varrette aka Falkor <sebastien.varrette@gmail.com>
#
# Copyright
# ---------
#
# Copyright 2016-2017 Nicolas Corrarello, Sebastien Varrette unless otherwise noted.
#
class reportslack (
  String $webhook,
  Enum[
    'present',
    'absent'
  ]      $ensure        = $reportslack::params::ensure,
  String $channel       = $reportslack::params::channel,
  String $puppetconsole = $settings::ca_server,
  String $username      = $reportslack::params::username,
  String $icon_url      = $reportslack::params::icon_url
)
inherits reportslack::params
{
  validate_re($webhook, 'https:\/\/hooks.slack.com\/(services\/)?T.+\/B.+\/.+', 'The webhook URL is invalid')
  validate_re($channel, '#.+', 'The channel should start with a hash sign')

  package { 'slack-notify':
    ensure   => latest,
    name     => $reportslack::params::gemname,
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
    ensure               => $ensure,
    path                 => "${settings::confdir}/puppet.conf",
    section              => 'master',
    setting              => 'reports',
    subsetting           => 'slack',
    subsetting_separator => ',',
    require              => Ini_setting['enable_reports'],
  }

  if defined(Package['pe-puppet']) {
    $owner = 'pe-puppet'
    $group = 'pe-puppet'
  }
  else {
    $owner = $reportslack::params::configfile_owner
    $group = $reportslack::params::configfile_group
  }
  file { $reportslack::params::configfile:
    ensure  => $ensure,
    owner   => $owner,
    group   => $group,
    mode    => $reportslack::params::configfile_mode,
    content => template('reportslack/slack.yaml.erb'),
    require => Package['slack-notify'],
  }
}
