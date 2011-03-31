# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gitinit/version"

Gem::Specification.new do |s|
  s.name        = "gitinit"
  s.version     = GitInit::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Mike Bethany"]
  s.email       = ["mikbe.tk@gmail.com"]
  s.homepage    = "http://mikbe.tk"
  s.summary     = %q{The easiest way to configure a new project!}
  s.description = %q{GitInit started out as a simple bash script to configure a git repo and push it to a remote server without having to configure the remote repo first. Now it's much more. You can easily add your own templates or use the ones provided.}

  s.add_dependency("commandable")

  s.add_development_dependency("rspec", "~>2.5")
  s.add_development_dependency("cucumber", "~>0.10")
  s.add_development_dependency("aruba", "~>0.3")

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
