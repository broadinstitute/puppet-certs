require 'spec_helper'

describe 'certs::site', :type => :define do
  let (:title) { 'base.example.org' }

  [ 'Debian', 'FreeBSD', 'Gentoo', 'RedHat', 'Suse' ].each do |osfamily|

    context "on #{osfamily}" do
      # This define requires the certs class, so make sure it's defined
      let :pre_condition do
        'class { "certs": }'
      end

      if osfamily == 'Debian'
        let(:facts) { {
          :osfamily                  => 'Debian',
          :operatingsystem           => 'Debian',
          :lsbdistid                 => 'Debian',
          :lsbdistcodename           => 'wheezy',
          :operatingsystemrelease    => '7.3',
          :operatingsystemmajrelease => '7',
        } }

        context 'with only cert and key content set' do
          let(:params) {
            {
              :cert_content => 'cert1111',
              :key_content  => 'key1111',
              :service      => :undef,
            }
          }

          it { should contain_file('/etc/ssl/certs').with_ensure('directory') }
          it { should contain_file('/etc/ssl/private').with_ensure('directory') }
          it { should contain_file('/etc/ssl/certs/base.example.org.crt').with_group('root') }
          it { should contain_file('/etc/ssl/private/base.example.org.key').with_group('root') }
        end

      end

      if osfamily == 'FreeBSD'
        let(:facts) { {
          :osfamily                  => osfamily,
          :operatingsystem           => 'FreeBSD',
          :operatingsystemrelease    => '10.0-RELEASE-p18',
          :operatingsystemmajrelease => '10',
        } }

        context 'with only cert and key content set' do
          let(:params) {
            {
              :cert_content => 'cert1111',
              :key_content  => 'key1111',
              :service      => :undef,
            }
          }

          it { should contain_file('/usr/local/etc/apache24').with_ensure('directory') }
          it { should contain_file('/usr/local/etc/apache24').with_group('wheel') }
          it { should contain_file('/usr/local/etc/apache24/base.example.org.crt').with_group('wheel') }
          it { should contain_file('/usr/local/etc/apache24/base.example.org.key').with_group('wheel') }
        end

      end

      if osfamily == 'Gentoo'
        let(:facts) { {
          :osfamily               => osfamily,
          :operatingsystem        => 'Gentoo',
          :operatingsystemrelease => '3.16.1-gentoo',
        } }

        context 'with only cert and key content set' do
          let(:params) {
            {
              :cert_content => 'cert1111',
              :key_content  => 'key1111',
              :service      => :undef,
            }
          }

          it { should contain_file('/etc/ssl/apache2').with_ensure('directory') }
          it { should contain_file('/etc/ssl/apache2').with_group('wheel') }
          it { should contain_file('/etc/ssl/apache2/base.example.org.crt').with_group('wheel') }
          it { should contain_file('/etc/ssl/apache2/base.example.org.key').with_group('wheel') }
        end

      end

      if osfamily == 'RedHat'
        let(:facts) { {
          :osfamily                  => osfamily,
          :operatingsystem           => 'RedHat',
          :operatingsystemrelease    => '7.2',
          :operatingsystemmajrelease => '7',
        } }

        context 'with only cert and key content set' do
          let(:params) {
            {
              :cert_content => 'cert1111',
              :key_content  => 'key1111',
              :service      => :undef,
            }
          }

          it { should contain_file('/etc/pki/tls/certs').with_ensure('directory') }
          it { should contain_file('/etc/pki/tls/private').with_ensure('directory') }
          it { should contain_file('/etc/pki/tls/certs/base.example.org.crt').with_group('root') }
          it { should contain_file('/etc/pki/tls/private/base.example.org.key').with_group('root') }
        end

      end
    end
  end

  context "on Debian-like setup for the remaining tests" do

    let(:facts) { {
      :osfamily                  => 'Debian',
      :operatingsystem           => 'Debian',
      :lsbdistid                 => 'Debian',
      :lsbdistcodename           => 'wheezy',
      :operatingsystemrelease    => '7.3',
      :operatingsystemmajrelease => '7',
    } }

    # This define requires the certs class, so make sure it's defined
    let :pre_condition do
      'class { "certs":
        cert_path => "/etc/ssl/certs",
        key_path  => "/etc/ssl/private",
      }'
    end

    context 'with only cert and key content set' do
      let(:params) {
        {
          :cert_content => 'cert1111',
          :key_content  => 'key1111',
          :service      => :undef,
        }
      }

      it { should contain_file('/etc/ssl/certs/base.example.org.crt').with_content(/cert1111/) }
      it { should contain_file('/etc/ssl/private/base.example.org.key').with_content(/key1111/) }
    end

    context 'with ensure => absent' do
      let(:params) {
        {
          :cert_content => 'cert',
          :key_content  => 'key',
          :service      => :undef,
          :ensure       => 'absent'
        }
      }

      it { should contain_file('/etc/ssl/certs/base.example.org.crt').with_ensure('absent') }
      it { should contain_file('/etc/ssl/private/base.example.org.key').with_ensure('absent') }
    end

    context 'with CA cert' do
      let(:params) {
        {
          :cert_content => 'cert1111',
          :key_content  => 'key1111',
          :service      => :undef,
          :ca_cert      => true,
          :ca_name      => 'ca',
          :ca_content   => 'ca2222',
          :ensure       => 'present'
        }
      }

      it { should contain_file('/etc/ssl/certs/base.example.org.crt').with_content(/cert1111/) }
      it { should contain_file('/etc/ssl/private/base.example.org.key').with_content(/key1111/) }
      it { should contain_file('/etc/ssl/certs/ca.crt').with_content(/ca2222/) }
    end

    context 'with chain cert' do
      let(:params) {
        {
          :cert_content => 'cert1111',
          :key_content  => 'key1111',
          :service      => :undef,
          :ca_cert      => true,
          :ca_name      => 'chain',
          :ca_content   => 'chain3333',
          :ensure       => 'present'
        }
      }

      it { should contain_file('/etc/ssl/certs/base.example.org.crt').with_content(/cert1111/) }
      it { should contain_file('/etc/ssl/private/base.example.org.key').with_content(/key1111/) }
      it { should contain_file('/etc/ssl/certs/chain.crt').with_content(/chain3333/) }
    end

    context 'with merge_chain set to true with CA' do
      let(:params) {
        {
          :cert_content => 'cert1111',
          :key_content  => 'key1111',
          :service      => :undef,
          :ensure       => 'present',
          :ca_cert      => true,
          :ca_name      => 'ca',
          :ca_content   => 'ca2222',
          :merge_chain  => true
        }
      }

      it { should contain_concat('base.example.org_cert_merged') }
      it {
        should contain_concat__fragment('base.example.org.crt_certificate').with(
          :content => /cert1111/ )
      }
      it {
        should contain_concat__fragment('base.example.org.crt_ca').with(
          :content => /ca2222/ )
      }
      it { should contain_file('/etc/ssl/private/base.example.org.key').with_content(/key1111/) }
      it { should contain_file('/etc/ssl/certs/ca.crt').with_content(/ca2222/) }
    end

    context 'with merge_chain set to true with chain' do
      let(:params) {
        {
          :cert_content  => 'cert1111',
          :key_content   => 'key1111',
          :service       => :undef,
          :ensure        => 'present',
          :cert_chain    => true,
          :chain_name    => 'chain',
          :chain_content => 'chain3333',
          :merge_chain   => true
        }
      }

      it { should contain_concat('base.example.org_cert_merged') }
      it {
        should contain_concat__fragment('base.example.org.crt_certificate').with(
          :content => /cert1111/ )
      }
      it {
        should contain_concat__fragment('base.example.org.crt_chain').with(
          :content => /chain3333/ )
      }
      it { should contain_file('/etc/ssl/private/base.example.org.key').with_content(/key1111/) }
      it { should contain_file('/etc/ssl/certs/chain.crt').with_content(/chain3333/) }
    end

    context 'with merge_chain set to true with CA and chain' do
      let(:params) {
        {
          :cert_content  => 'cert1111',
          :key_content   => 'key1111',
          :service       => :undef,
          :ensure        => 'present',
          :cert_chain    => true,
          :chain_name    => 'chain',
          :chain_content => 'chain3333',
          :ca_cert       => true,
          :ca_name       => 'ca',
          :ca_content    => 'ca2222',
          :merge_chain   => true
        }
      }

      it { should contain_concat('base.example.org_cert_merged') }
      it {
        should contain_concat__fragment('base.example.org.crt_certificate').with(
          :content => /cert1111/ )
      }
      it {
        should contain_concat__fragment('base.example.org.crt_ca').with(
          :content => /ca2222/ )
      }
      it {
        should contain_concat__fragment('base.example.org.crt_chain').with(
          :content => /chain3333/ )
      }
      it { should contain_file('/etc/ssl/private/base.example.org.key').with_content(/key1111/) }
      it { should contain_file('/etc/ssl/certs/ca.crt').with_content(/ca2222/) }
      it { should contain_file('/etc/ssl/certs/chain.crt').with_content(/chain3333/) }
    end

    context 'with a custom user set' do
      let(:params) {
        {
          :cert_content  => 'cert1111',
          :key_content   => 'key1111',
          :service       => :undef,
          :ensure        => 'present',
          :cert_chain    => true,
          :chain_name    => 'chain',
          :chain_content => 'chain3333',
          :ca_cert       => true,
          :ca_name       => 'ca',
          :ca_content    => 'ca2222',
          :owner         => 'newowner',
        }
      }

      it { should contain_file('/etc/ssl/certs/base.example.org.crt').with_owner('newowner') }
      it { should contain_file('/etc/ssl/private/base.example.org.key').with_owner('newowner') }
      it { should contain_file('/etc/ssl/certs/ca.crt').with_owner('newowner') }
      it { should contain_file('/etc/ssl/certs/chain.crt').with_owner('newowner') }
    end

    context 'with a custom group set' do
      let(:params) {
        {
          :cert_content  => 'cert1111',
          :key_content   => 'key1111',
          :service       => :undef,
          :ensure        => 'present',
          :cert_chain    => true,
          :chain_name    => 'chain',
          :chain_content => 'chain3333',
          :ca_cert       => true,
          :ca_name       => 'ca',
          :ca_content    => 'ca2222',
          :group         => 'newgroup',
        }
      }

      it { should contain_file('/etc/ssl/certs/base.example.org.crt').with_group('newgroup') }
      it { should contain_file('/etc/ssl/private/base.example.org.key').with_group('newgroup') }
      it { should contain_file('/etc/ssl/certs/ca.crt').with_group('newgroup') }
      it { should contain_file('/etc/ssl/certs/chain.crt').with_group('newgroup') }
    end

    context 'with a custom file and directory modes set' do
      let(:params) {
        {
          :cert_content  => 'cert1111',
          :key_content   => 'key1111',
          :service       => :undef,
          :ensure        => 'present',
          :cert_chain    => true,
          :chain_name    => 'chain',
          :chain_content => 'chain3333',
          :ca_cert       => true,
          :ca_name       => 'ca',
          :ca_content    => 'ca2222',
          :cert_mode     => '0700',
          :key_mode      => '0400',
          :cert_dir_mode => '0500',
          :key_dir_mode  => '0500',
        }
      }

      it { should contain_file('/etc/ssl/certs').with_ensure('directory') }
      it { should contain_file('/etc/ssl/certs').with_mode('0500') }
      it { should contain_file('/etc/ssl/private').with_ensure('directory') }
      it { should contain_file('/etc/ssl/private').with_mode('0500') }

      it { should contain_file('/etc/ssl/certs/base.example.org.crt').with_mode('0700') }
      it { should contain_file('/etc/ssl/private/base.example.org.key').with_mode('0400') }
      it { should contain_file('/etc/ssl/certs/ca.crt').with_mode('0700') }
      it { should contain_file('/etc/ssl/certs/chain.crt').with_mode('0700') }
    end

    context 'with custom extensions set' do
      let(:params) {
        {
          :cert_content  => 'cert1111',
          :key_content   => 'key1111',
          :service       => :undef,
          :ensure        => 'present',
          :cert_chain    => true,
          :chain_name    => 'chain',
          :chain_content => 'chain3333',
          :ca_cert       => true,
          :ca_name       => 'ca',
          :ca_content    => 'ca2222',
          :cert_ext      => '.pem',
          :key_ext       => '.pem',
          :ca_ext        => '.pem',
          :chain_ext     => '.pem',
        }
      }

      it { should contain_file('/etc/ssl/certs/base.example.org.pem') }
      it { should contain_file('/etc/ssl/private/base.example.org.pem') }
      it { should contain_file('/etc/ssl/certs/ca.pem') }
      it { should contain_file('/etc/ssl/certs/chain.pem') }
    end
  end
end
