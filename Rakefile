require 'rubygems'
require 'bundler/setup'

require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'
require 'puppet/version'
require 'puppetlabs_spec_helper/rake_tasks'

exclude_paths = [
    "bundle/**/*",
    "pkg/**/*",
    "vendor/**/*",
    "spec/**/*",
]

Rake::Task[:lint].clear

PuppetLint.configuration.relative = true
PuppetLint.configuration.send("disable_80chars")
PuppetLint.configuration.log_format = "%{path}:%{linenumber}:%{check}:%{KIND}:%{message}"
PuppetLint.configuration.fail_on_warnings = true
PuppetLint.configuration.disable_documentation

# Forsake support for Puppet 2.6.2 for the benefit of cleaner code.
# http://puppet-lint.com/checks/class_parameter_defaults/
PuppetLint.configuration.send('disable_class_parameter_defaults')
# http://puppet-lint.com/checks/class_inherits_from_params_class/
PuppetLint.configuration.send('disable_class_inherits_from_params_class')
# To fix unquoted cases in spec/fixtures/modules/apt/manifests/key.pp
PuppetLint.configuration.send('disable_unquoted_string_in_case')

PuppetLint.configuration.ignore_paths = exclude_paths

PuppetSyntax.exclude_paths = exclude_paths

# These two gems aren't always present, for instance
# on Travis with --without development

# Prevent fixtures from being deleted on each successful run by cutting out
# the spec_clean task
# https://projects.puppetlabs.com/issues/20013
Rake::Task[:spec].clear
task :spec do
    Rake::Task[:spec_prep].invoke
    Rake::Task[:spec_standalone].invoke
end

begin
    require 'puppet_blacksmith/rake_tasks'
rescue LoadError
end

task :metadata_lint do
    sh "bundle exec metadata-json-lint metadata.json"
end

desc "Run syntax, lint, and spec tests."
task :test => [
    :syntax,
    :lint,
    :spec,
    :metadata_lint,
]
