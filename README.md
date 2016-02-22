# reportslack

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with reportslack](#setup)
    * [What reportslack affects](#what-reportslack-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with reportslack](#beginning-with-reportslack)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module enables notifications from Puppet Enterprise to your Slack channel, when there are changes in your infrastructure.

## Module Description

This module configures a Puppet Enterprise custom report processor that sends notifications to your slack channel, whenever an agent run has triggered a change in your infrastructure.

## Setup

### What reportslack affects

* Installs the slack-notifier gem that creates the notifications.
* Adds an extra report processor to puppet.conf .
* Creates an extra report processor (slack).

### Setup Requirements 

If your module requires anything extra before setting up (pluginsync enabled,
etc.), mention it here.

### Beginning with reportslack

<a href="https://slack.com/oauth/authorize?scope=incoming-webhook&client_id=2176880835.22484045430"><img alt="Add to Slack" height="40" width="139" src="https://platform.slack-edge.com/img/add_to_slack.png" srcset="https://platform.slack-edge.com/img/add_to_slack.png 1x, https://platform.slack-edge.com/img/add_to_slack@2x.png 2x"></a>

Click on the button above to obtain the Webhook URL required to start getting notifications in your channel.
Then simply classify your PE Master group with the reportslack class, setting the webhook_url and channel variable as you got from Slack. 

## Usage

Put the classes, types, and resources for customizing, configuring, and doing
the fancy stuff with your module here.

## Reference

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module so
people know what the module is touching on their system but don't need to mess
with things. (We are working on automating this section!)

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You may also add any additional sections you feel are
necessary or important to include here. Please use the `## ` header.
