require 'bundler/setup'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'
require 'puppet/version'
require 'puppetlabs_spec_helper/rake_tasks'
require 'rubygems'

exclude_paths = [
  "bundle/**/*",
  "pkg/**/*",
  "vendor/**/*",
  "spec/**/*",
]

Rake::Task[:lint].clear

PuppetLint.configuration.relative = true
PuppetLint.configuration.disable_80chars
PuppetLint.configuration.disable_documentation
PuppetLint.configuration.disable_class_inherits_from_params_class
PuppetLint.configuration.fail_on_warnings = true

PuppetLint::RakeTask.new :lint do |config|
  config.ignore_paths = exclude_paths
end

PuppetSyntax.exclude_paths = exclude_paths

desc "Run syntax and lint tests."
task :default => [
  :syntax,
  :lint,
]
