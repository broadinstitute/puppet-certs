#!/usr/bin/env bash

export PUPPET_GEM_VERSION='>= 4.0.0'

rpm -Uvh http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs-PC1
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-PC1
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-nightly-puppetlabs-PC1
yum -y install git puppet-agent ruby-devel vim
mv /tmp/Gemfile /etc/puppetlabs/code/
mv /tmp/hiera.yaml /etc/puppetlabs/code/
mkdir -p /etc/puppetlabs/code/hieradata
touch /etc/puppetlabs/code/hieradata/global.yaml
gem install bundle rake --no-rdoc --no-ri
/usr/local/bin/bundle config --global silence_root_warning 1
cd /etc/puppetlabs/code/modules/certificates
rm -f Gemfile.lock
/usr/local/bin/bundle install --with development
rm -f Puppetfile.lock
/usr/local/bin/librarian-puppet install --verbose --path=/etc/puppetlabs/code/modules
