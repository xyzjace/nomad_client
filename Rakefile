require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'yard'
RSpec::Core::RakeTask.new(:spec)

task :default => :spec

## Yardoc docset generation
YARD::Rake::YardocTask.new do |t|
 t.files   = ['lib/**/*.rb']
end
