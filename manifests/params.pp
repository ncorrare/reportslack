# -*- mode: puppet; -*-
# Time-stamp: <Thu 2017-05-25 01:41 svarrette>
# ------------------------------------------------------------------------------
# = Class: reportslack::params
#
# In this class are defined as variables values that are used in other
# reportslack classes.
# This class should be included, where necessary, and eventually be enhanced
# with support for more OS
#
# == Warnings
#
# /!\ Always respect the style guide available
# here[http://docs.puppetlabs.com/guides/style_guide]
#
# The usage of a dedicated param classe is advised to better deal with
# parametrized classes, see
# http://docs.puppetlabs.com/guides/parameterized_classes.html
#
# [Remember: No empty lines between comments and class definition]
#
class reportslack::params {

  ######## DEFAULTS FOR VARIABLES USERS CAN SET ##########################
  # (Here are set the defaults, provide your custom variables externally)
  # (The default used is in the line with '')
  ###########################################

  # ensure the presence (or absence) of reportslack
  $ensure   = 'present'
  $channel  = '#general'
  $username = 'Puppet'
  $icon_url = 'https://learn.puppet.com/static/images/logos/Puppet-Logo-Mark-Amber.png'

  #### MODULE INTERNAL VARIABLES  #########
  # (Modify to adapt to unsupported OSes)
  #######################################
  $packagename = $::operatingsystem ? {
    default => 'slack-notifier',
  }

  $configfile = $::operatingsystem ? {
    default => "${settings::confdir}/slack.yaml",
  }
  $configfile_mode = $::operatingsystem ? {
    default => '0640',
  }

  $configfile_owner = $::operatingsystem ? {
    default => 'puppet',
  }

  $configfile_group = $::operatingsystem ? {
    default => 'puppet',
  }

}
