Gem::Specification.new do |s|
  s.name              = "fake-gem"
  s.version           = "0.1.1"
  s.summary           = "Make RubyGems think that a gem is already installed."
  s.author            = "Paul Battley"
  s.email             = "pbattley@gmail.com"
  s.homepage          = "http://github.com/threedaymonk/fake-gem"

  s.has_rdoc          = false

  s.files             = Dir["{bin,lib/**/*}"]
  s.executables       = Dir["bin/**"].map { |f| File.basename(f) }
  s.require_paths     = ["lib"]
end
