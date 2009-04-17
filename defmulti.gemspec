# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{defmulti}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Francois Beausoleil"]
  s.date = %q{2009-04-17}
  s.description = %q{A thought experiment on a language that doesn't have if/then/else constructs.}
  s.email = %q{francois@teksol.info}
  s.extra_rdoc_files = [
    "README.textile"
  ]
  s.files = [
    "README.textile",
    "Rakefile",
    "VERSION.yml",
    "lib/defmulti.rb",
    "test/defmulti_test.rb",
    "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/francois/defmulti}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A thought experiment on a language that doesn't have if/then/else constructs.}
  s.test_files = [
    "test/defmulti_test.rb",
    "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<dfect>, [">= 0.0.0"])
    else
      s.add_dependency(%q<dfect>, [">= 0.0.0"])
    end
  else
    s.add_dependency(%q<dfect>, [">= 0.0.0"])
  end
end
