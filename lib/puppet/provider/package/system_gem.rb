require 'puppet/provider/package'

Puppet::Type.type(:package).provide :system_gem, :parent => :gem do
  desc 'Puppet System Ruby Gem support, workaround for PUP-6134'

  has_feature :versionable, :install_options, :uninstall_options

  self.debug 'Using the system_gem package provider, workaround for PUP-6134'

  if Puppet.features.microsoft_windows?
    # Puppet on Windows prepends its paths to PATH. One of those paths includes Puppet's RUBY_DIR.
    # That results in the which() method in self.command(name) in lib/puppet/provider.rb always returning Puppet's ruby 'gem' command.
    # To prevent this, call which('gem') with a PATH without Puppet's RUBY_DIR, and set :gemcmd to the full-path result.
    env_ruby_dir = Puppet::Util.get_env('RUBY_DIR')
	if env_ruby_dir.nil?
	  commands :gemcmd => "gem"
	else
      puppet_ruby_bin_path = env_ruby_dir + '\bin'
      path_as_array = Puppet::Util.get_env('PATH').split(';')
      path_as_array.reject! {|p| p == puppet_ruby_bin_path}
      path_without_path = path_as_array.join(';')
      commands :gemcmd => Puppet::Util.withenv({:PATH => path_without_path}, :windows) { which('gem') }
	end
  else
    commands :gemcmd => "gem"
  end

end
