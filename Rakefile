desc "Runs unit tests"
task :test do
  files = FileList["test/**/*_test.rb"]
  commandline = files.inject("ruby -Ilib:test -rubygems -e '") do |memo, filename|
    memo << " require \"#{filename}\""
  end
  commandline << "'"
  sh commandline
end

task :default => :test
