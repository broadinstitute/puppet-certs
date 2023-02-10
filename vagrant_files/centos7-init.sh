#!/usr/bin/env bash

rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs
yum -y install git puppet ruby-devel vim
mv /tmp/Gemfile /etc/puppetlabs/code/
mv /tmp/Gemfile.lock /etc/puppetlabs/code/
mv /tmp/hiera.yaml /etc/puppetlabs/code/
mkdir -p /etc/puppetlabs/code/hieradata
mkdir -p /etc/puppetlabs/code/modules
touch /etc/puppetlabs/code/hieradata/global.yaml
gem install bundle rake --no-rdoc --no-ri
/usr/local/bin/bundle config --global silence_root_warning 1
cd /etc/puppetlabs/code
/usr/local/bin/bundle install
cd /etc/puppetlabs/code/modules/certificates
rm -f Puppetfile.lock
/usr/local/bin/librarian-puppet install --verbose --path=/etc/puppetlabs/code/modules
