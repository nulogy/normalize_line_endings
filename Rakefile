require "bundler/gem_tasks"

require "rake"
require "rake/testtask"
require "rdoc/task"

desc "Default: run unit tests."
task default: :test

desc "Test the stripattributes plugin."
Rake::TestTask.new(:test) do |t|
  t.libs << "lib"
  t.pattern = "test/**/*_test.rb"
end

desc "Generate documentation for the stripattributes plugin."
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = "rdoc"
  rdoc.title    = "Stripattributes"
  rdoc.options << "--line-numbers" << "--inline-source"
  rdoc.rdoc_files.include("README.rdoc")
  rdoc.rdoc_files.include("lib/**/*.rb")
end
