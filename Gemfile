source 'https://rubygems.org'

puppetversion = ENV['PUPPET_GEM_VERSION']
gem 'facter', '>= 1.7.0'
gem 'metadata-json-lint'
gem 'puppet', puppetversion
gem 'puppetlabs_spec_helper', '>= 0.1.0'
gem 'puppet-lint', '>= 0.3.2'
gem 'puppet-syntax'
# Make sure public_suffix is less than 3.0.0 if ruby < 2.1
gem 'public_suffix', '< 3.0.0', :require => false if RUBY_VERSION =~ /^2\.0\./
gem 'rake'
gem 'requests'
gem 'rspec'
gem 'rspec-puppet'
gem 'rspec-puppet-utils'

group :development do
  gem 'librarian-puppet', :require => false
end
