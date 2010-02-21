require 'rubygems/command_manager'
require 'rubygems/command'
require 'fake_gem'

class Gem::Commands::FakeCommand < Gem::Command
  def initialize
    super "fake", "Make RubyGems think that the named gem is already installed."

    add_option(
      "-v", "--version VERSION",
      "Specify a version for the gem (default is #{FakeGem::DEFAULT_VERSION})"
    ) do |value, options|
      options[:version] = value
    end
  end

  def summary # :nodoc:
    FakeGem::SUMMARY
  end

  def usage # :nodoc:
    "#{program_name} GEMNAME"
  end

  def execute
    FakeGem.new(options[:args].first, options).install
  end
end

Gem::CommandManager.instance.register_command :fake
