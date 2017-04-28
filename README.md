# system_gem

#### Table of Contents

1. [Description](#description)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)

## Description

This a workaround for PUP-6134: Unable to install a Ruby gem to non-Puppet Ruby stack using the package resource type on Windows

## Usage

To use this package provider, specify it as the provider of a package.

~~~
package { 'sinatra':
  ensure   => present,
  provider => system_gem,
}
~~~

## Reference

Puppet is unable to install a ruby gem anywhere other than Puppet's ruby via the gem package provider on Windows.
This is caused by Puppet prepending its paths (including the path to Puppet's ruby gem command) to PATH.
This workaround removes Puppet's paths from PATH when setting :gemcmd.

While the system_gem package provider is meant as a workaround for an issue specific to Windows, 
it is compatible with the other operating systems supported by the parent gem package provider.
