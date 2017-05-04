# system_gem

#### Table of Contents

1. [Description](#description)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations](#limitations)

## Description

This a workaround for PUP-6134:

Unable to install a Ruby gem to non-Puppet Ruby stack using the package resource type on Windows

## Usage

Install this module, and specify `system_gem` as the provider of gem packages.

~~~
package { 'sinatra':
  ensure   => present,
  provider => system_gem,
}
~~~

Once PUP-6134 has been resolved, specify `gem` as the provider of gem packages, and uninstall this module.

## Reference

On Windows ...

Puppet is unable to manage a ruby gem anywhere other than in Puppet's ruby using the gem package provider.
This is caused by Puppet prepending its paths (including the path to Puppet's ruby gem command) to PATH.
This workaround removes Puppet's paths from PATH when setting :gemcmd.

## Limitations

While the system_gem package provider is meant as a workaround for an issue specific to Windows, 
it is compatible with the other operating systems supported by the parent gem package provider.