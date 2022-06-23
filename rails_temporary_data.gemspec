# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rails_temporary_data/version"

Gem::Specification.new do |s|
  s.name        = "rails_temporary_data"
  s.version     = RailsTemporaryData::VERSION
  s.authors     = ["Vlado Cingel"]
  s.email       = ["vladocingel@gmail.com"]
  s.homepage    = "https://github.com/vlado/rails_temporary_data"
  s.summary     = %q{Rails engine to simply save temporary data that is too big for session in database}
  s.description = %q{Rails engine to simply save temporary data that is too big for session in database}

  s.rubyforge_project = "rails_temporary_data"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency("rake")
  s.add_development_dependency("pg")

  s.add_dependency("rails")
end
