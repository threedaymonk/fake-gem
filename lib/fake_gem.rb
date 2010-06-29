require "fileutils"
require "tmpdir"
require "rubygems/installer"

class FakeGem
  DEFAULT_VERSION = "99.0.0"
  SUMMARY = "Make RubyGems think that a gem is already installed."

  include Gem::UserInteraction

  def initialize(name, options={})
    @name = name
    @options = {:install_dir => Gem.dir}.merge(options)
    @version = options.delete(:version) || DEFAULT_VERSION
  end

  def install
    temp_path = File.join(Dir.tmpdir, "fakegem.#{Process.pid}")
    FileUtils.mkdir_p(temp_path)
    Dir.chdir(temp_path) do
      build_gem
      Gem::Installer.new(specification.file_name, @options).install
    end
    say "Fake gem #@name #@version is now installed"
  end

private
  def specification
    @specification ||= Gem::Specification.new{ |s|
      s.name          = @name
      s.version       = @version
      s.summary       = "Fake #@name gem"
      s.author        = "Nobody"
      s.email         = "nobody@localhost"
      s.has_rdoc      = false
      s.files         = []
      s.executables   = []
      s.require_paths = ["lib"]
    }
  end

  def build_gem
    FileUtils.mkdir_p("lib")
    Gem::Builder.new(specification).build
  end
end
