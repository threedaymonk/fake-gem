# fake-gem

Make RubyGems think that a gem is already installed.

## Usage

    gem fake GEMNAME
    gem fake --version VERSION GEMNAME

The default version is 99.0.0, which ought to be higher than any genuine gem.

## Why?

There are two use cases for this gem.

### System packages

The first is when the system package manager provides some libraries natively.
For example, Ubuntu supplies a pre-built nokogiri library. Instead of fetching
all the prerequisites and compiling, you can just do:

    sudo apt-get install libnokogiri-ruby

But if you subsequently install a gem that requires on Nokogiri, you'll have to
build Nokogiri via RubyGems, because RubyGems doesn't know that it's already
available. Now, you can make RubyGems think that it's already installed:

    sudo gem fake --version 1.3.1 nokogiri

Anything that's happy with version 1.3.1 of Nokogiri will install without
further effort. (If you need a newer version, of course, you're stuck with the
hard way.)

### Rubbish dependencies

Does anyone want to install Hoe, RubyForge, etc., just because some gem erroneously
specified it as a requirement?

Thought not.

    gem fake hoe rubyforge

They won't come back 'round here no more.
