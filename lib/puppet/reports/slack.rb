require 'puppet'
require 'yaml'
require 'slack-notify'

Puppet::Reports.register_report(:slack) do
  desc "A custom reports processor to send notifications to a Slack channel"

  if (Puppet.settings[:config]) then
    @configfile = File.join([File.dirname(Puppet.settings[:config]), "slack.yaml"])
  else
    @configfile = "/etc/puppetlabs/puppet/slack.yaml"
  end
  Puppet.debug "Reading #{@configfile}"
  raise(Puppet::ParseError, "Slack report config file #{@configfile} not readable") unless File.exist?(@configfile)
  @config = YAML.load_file(@configfile)

  options = {
    webhook_url: @config['webhook_url'],
    channel:     @config['channel']
  }
  ['username', 'icon_url', 'icon_emoji', 'link_names'].each do |k|
    options[k] = @config[k] if @config[k]
  end
  PUPPETCONSOLE = @config['puppetconsole']
  DISABLED_FILE = File.join([File.dirname(Puppet.settings[:@config]), 'slack_disabled'])

  def process
    disabled = File.exists?(DISABLED_FILE)

    if (!disabled && self.status != 'unchanged')
      Puppet.debug "Sending notification for #{self.host} to Slack channel #{@config['channel']}"
      msg = "Puppet run for #{self.host} #{self.status} at #{Time.now.asctime} on #{self.configuration_version} in #{self.environment}. Report available <https://#{PUPPETCONSOLE}/#/node_groups/inventory/node/#{self.host}/reports|here>"
      notifier = Slack::Notifier.new(options)
      notifier.notify(msg)
    end
  end
end
