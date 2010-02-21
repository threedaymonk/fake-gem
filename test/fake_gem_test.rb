$:.unshift File.expand_path("../../lib", __FILE__)
require "test/unit"
require "fake_gem"
require "rubygems"
require "rubygems/uninstaller"

class FakeGemTest < Test::Unit::TestCase

  def assert_not_installed(name, version)
    assert !installed?(name, version)
  end

  def assert_installed(name, version)
    assert installed?(name, version)
  end

  def installed?(name, version)
    Gem.source_index.find_name(name).any?{ |g| g.version.to_s == version }
  end

  def setup
    Gem.source_index.refresh!
    @to_remove = []
  end

  def teardown
    @to_remove.uniq.each do |name|
      Gem.source_index.find_name(name).each do |g|
        Gem::Uninstaller.new(
          name,
          :version      => g.version.to_s,
          :user_install => true
        ).uninstall
      end
    end
  end

  def test_should_install_fake_gem_with_specific_version
    name    = "made-up-gem-name"
    version = "1.2.3"
    @to_remove << name
    assert_not_installed name, version
    FakeGem.new(name, :version => version).install
    assert_installed name, version
  end

  def test_should_use_absurdly_high_version_by_default
    name    = "made-up-gem-name"
    version = "99.0.0"
    @to_remove << name
    assert_not_installed name, version
    FakeGem.new(name).install
    assert_installed name, version
  end

end
