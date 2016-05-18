require_relative 'tpl'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task :default => :spec
  task :test => :spec
end

task :refresh do
  t = Tpl.new
  t.refresh
end
