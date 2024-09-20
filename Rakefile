# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "standard/rake"

task default: %i[spec standard]

desc "Run StandardRB linter and automatically fix issues"
task :lint do
  sh "bundle exec standardrb"
end

desc "Run bundle-audit to check for gems' vulnerabilities"
task :audit do
  sh "bundle exec bundle-audit check --update"
end
