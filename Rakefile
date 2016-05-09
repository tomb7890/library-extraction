# rubocop:disable HashSyntax

require 'rspec/core/rake_task'
require 'rubocop/rake_task'

require_relative 'tpl'

RuboCop::RakeTask.new

task :default => [:spec]

if 'test' == ENV['ENV']
  desc 'Run the specs.'
  RSpec::Core::RakeTask.new do |t|
    t.pattern = '*_spec.rb'
  end
else
  t = Tpl.new
  t.refresh
end
