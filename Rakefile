begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name              = "defmulti"
    s.description       = # Continued on next line
    s.summary           = "A thought experiment on a language that doesn't have if/then/else constructs."
    s.email             = "francois@teksol.info"
    s.homepage          = "http://github.com/francois/defmulti"
    s.authors           = "Francois Beausoleil"
    s.has_rdoc          = false
    s.rubyforge_project = nil

    s.add_development_dependency "dfect", ">= 0.0.0"
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

desc "Runs unit tests"
task :test do
  files = FileList["test/**/*_test.rb"]
  commandline = files.inject("ruby -Ilib:test:../dfect/lib -rubygems -e '") do |memo, filename|
    memo << " require \"#{filename}\""
  end
  commandline << "'"
  sh commandline
end

task :default => :test
