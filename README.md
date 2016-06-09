# reportslack

[![Build Status](https://travis-ci.org/ncorrare/reportslack.svg?branch=master)](https://travis-ci.org/ncorrare/reportslack)
[![Coverage Status](https://coveralls.io/repos/github/ncorrare/reportslack/badge.svg?branch=master)](https://coveralls.io/github/ncorrare/reportslack?branch=master)

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

The module needs pluginsync enabled. It also requires a manual restart of the pe-puppetserver that I've purposely left out of the Puppet code.
### Beginning with reportslack

Set up an Incoming Webhook on Slack. Use the "Add to slack" button below and follow the process to get an incoming webhook url.

<a href="https://slack.com/oauth/authorize?scope=incoming-webhook&client_id=22553403825.31138671813&state=JWOWndvoFQJk"><img alt="Add to Slack" height="40" width="139" src="https://platform.slack-edge.com/img/add_to_slack.png" srcset="https://platform.slack-edge.com/img/add_to_slack.png 1x, https://platform.slack-edge.com/img/add_to_slack@2x.png 2x" /></a>



Then simply classify your PE Master group with the reportslack class, setting the webhook_url and channel variable as you got from Slack. 

You should get notifications similar to the following in the Slack channel you've chosen:
<img alt="Example image" width="606" height="182" src="https://raw.githubusercontent.com/ncorrare/reportslack/master/example.png">
## Usage

Look at tests/init.pp for an example implementation.

## Limitations

This module has only been tested with Puppet Enterprise

## Development

Regular rules apply, fork & PR.

## Thanks

Thanks to dylanratcliffe and jamtur01 for their code examples!
Also thanks to atarinut for their PRs.
