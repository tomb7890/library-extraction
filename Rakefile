require_relative 'tpl'

task :default => :refresh 

desc "Retrieve TPL account info and write to Org Mode agenda file"  
task :refresh do
  t = Tpl.new
  t.refresh
end
