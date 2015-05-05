require 'bundler/gem_tasks'
require 'rubocop/rake_task'
require 'reek/rake/task'
require 'roodi_task'

task audit: [:style, :complexity, :duplication, :design, :documentation]

task style: [:rubocop]

desc 'Enforce Style Conformance with RuboCop'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb']
  task.fail_on_error = false
end

task complexity: [:flog]

desc 'Assess Complexity with Flog'
# FlogTask.new :flog, 9000, ['lib']
task :flog do
  sh 'flog lib/**/*.rb'
end

task duplication: [:flay]

task :flay do
  sh 'flay'
end

task design: [:roodi, :reek]

desc 'Find Code Smells with Reek'
Reek::Rake::Task.new(:reek) do |task|
  task.fail_on_error = false
end

task :documentation do
  sh 'inch'
end
