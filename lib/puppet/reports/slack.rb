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
  raise(Puppet::ParseError, "Unable to parse the YAML file #{@configfile}") if @config.nil?
  # Prepare Constant variables to be used within the process definition
  SLACK_WEBHOOK_URL = @config['webhook_url']
  SLACK_CHANNEL     = @config['channel']
  SLACK_USERNAME    = (@config['username']      ? @config['username']      : '')
  SLACK_ICON_URL    = (@config['icon_url']      ? @config['icon_url']      : '')
  SLACK_ICON_EMOJI  = (@config['icon_emoji']    ? @config['icon_emoji']    : '')
  PUPPETCONSOLE     = (@config['puppetconsole'] ? @config['puppetconsole'] : '')
  PUPPETBOARD       = (@config['puppetboard']   ? @config['puppetboard']   : '')
  FOREMAN           = (@config['foreman']       ? @config['foreman']       : '')
  DISABLED_FILE = "#{@configfile}.disabled"

  def process
    disabled = File.exists?(DISABLED_FILE)

    if (!disabled && self.status != 'unchanged')
      Puppet.debug "Sending notification for #{self.host} to Slack channel #{SLACK_CHANNEL}"
      options = {
        webhook_url: SLACK_WEBHOOK_URL,
        channel:     SLACK_CHANNEL
      }
      options[:username]   = SLACK_USERNAME   unless SLACK_USERNAME.empty?
      options[:icon_url]   = SLACK_ICON_URL   unless SLACK_ICON_URL.empty?
      options[:icon_emoji] = SLACK_ICON_EMOJI unless SLACK_ICON_EMOJI.empty?
      # Prepare the message to display
      msg = "Puppet run for #{self.host} #{self.status} at #{Time.now.asctime} on #{self.configuration_version} in #{self.environment}. Report available "
      #Report available <https://#{PUPPETCONSOLE}/#/node_groups/inventory/node/#{self.host}/reports|here>"
      # TODO: adapt the link
      client = SlackNotify::Client.new(options)
      client.notify(msg)
    end
  end
end
