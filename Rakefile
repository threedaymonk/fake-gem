require "rubygems"
require 'rake/testtask'
require "rake/gempackagetask"

task :default => :test

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
end

spec = Gem::Specification.new do |s|
  s.name              = "fake-gem"
  s.version           = "0.1.0"
  s.summary           = "Make RubyGems think that a gem is already installed."
  s.author            = "Paul Battley"
  s.email             = "pbattley@gmail.com"
  s.homepage          = "http://github.com/threedaymonk/fake-gem"

  s.has_rdoc          = false

  s.files             = FileList["{bin,lib/**/*}"]
  s.executables       = FileList["bin/**"].map { |f| File.basename(f) }
  s.require_paths     = ["lib"]
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end
