require 'spec_helper'

describe 'certificates::site', type: :define do
  let(:title) { 'base.example.org' }

  ['Debian', 'FreeBSD', 'Gentoo', 'RedHat', 'Suse'].each do |osfamily|
    context "on #{osfamily}" do
      # This define requires the certificates class, so make sure it's defined
      let :pre_condition do
        'class { "certificates": service => false, validate_x509 => false, cert_content => "cert1111", key_content => "key1111" }'
      end

      if osfamily == 'Debian'
        let(:facts) do
          {
            'lsbdistcodename'           => 'wheezy',
            'lsbdistid'                 => 'Debian',
            'operatingsystem'           => 'Debian',
            'operatingsystemmajrelease' => '9',
            'operatingsystemrelease'    => '9.5',
            'osfamily'                  => 'Debian',
          }
        end

        context 'with only cert and key content set' do
          it {
            is_expected.to contain_file('/etc/ssl/certs').with_ensure('directory')
          }
          it {
            is_expected.to contain_file('/etc/ssl/private').with_ensure('directory')
          }
          it {
            is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').with_group('root')
          }
          it {
            is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_group('root')
          }
        end
      end

      if osfamily == 'FreeBSD'
        let(:facts) do
          {
            'operatingsystem'           => 'FreeBSD',
            'operatingsystemmajrelease' => '10',
            'operatingsystemrelease'    => '10.0-RELEASE-p18',
            'osfamily'                  => osfamily,
          }
        end

        context 'with only cert and key content set' do
          it {
            is_expected.to contain_file('/usr/local/etc/apache24').with_ensure('directory')
          }
          it {
            is_expected.to contain_file('/usr/local/etc/apache24').with_group('wheel')
          }
          it {
            is_expected.to contain_file('/usr/local/etc/apache24/base.example.org.crt').with_group('wheel')
          }
          it {
            is_expected.to contain_file('/usr/local/etc/apache24/base.example.org.key').with_group('wheel')
          }
        end
      end

      if osfamily == 'Gentoo'
        let(:facts) do
          {
            'operatingsystem'        => 'Gentoo',
            'operatingsystemrelease' => '3.16.1-gentoo',
            'osfamily'               => osfamily,
          }
        end

        context 'with only cert and key content set' do
          it {
            is_expected.to contain_file('/etc/ssl/apache2').with_ensure('directory')
          }
          it {
            is_expected.to contain_file('/etc/ssl/apache2').with_group('wheel')
          }
          it {
            is_expected.to contain_file('/etc/ssl/apache2/base.example.org.crt').with_group('wheel')
          }
          it {
            is_expected.to contain_file('/etc/ssl/apache2/base.example.org.key').with_group('wheel')
          }
        end
      end

      if osfamily == 'RedHat'
        let(:facts) do
          {
            'operatingsystem'           => 'RedHat',
            'operatingsystemmajrelease' => '7',
            'operatingsystemrelease'    => '7.5',
            'osfamily'                  => osfamily,
          }
        end

        context 'with only cert and key content set' do
          it {
            is_expected.to contain_file('/etc/pki/tls/certs').with_ensure('directory')
          }
          it {
            is_expected.to contain_file('/etc/pki/tls/private').with_ensure('directory')
          }
          it {
            is_expected.to contain_file('/etc/pki/tls/certs/base.example.org.crt').with_group('root')
          }
          it {
            is_expected.to contain_file('/etc/pki/tls/private/base.example.org.key').with_group('root')
          }
        end
      end
    end
  end

  context 'on Debian-like setup for the remaining tests' do
    let(:facts) do
      {
        'lsbdistcodename'           => 'wheezy',
        'lsbdistid'                 => 'Debian',
        'operatingsystem'           => 'Debian',
        'operatingsystemmajrelease' => '9',
        'operatingsystemrelease'    => '9.5',
        'osfamily'                  => 'Debian',
      }
    end

    # This define requires the certificates class, so make sure it's defined
    let :pre_condition do
      'class { "certificates": service => false, validate_x509 => false}'
    end

    context 'with only cert and key content set' do
      let(:params) do
        {
          'cert_content'  => 'cert1111',
          'key_content'   => 'key1111',
        }
      end

      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').with_content(%r{cert1111})
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_content(%r{key1111})
      }
    end

    context 'with only cert and key using source_path' do
      let(:params) do
        {
          'source_path'   => 'puppet:///site_certs/base.example.org',
        }
      end

      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.crt})
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.key})
      }
    end

    context 'with ensure => absent' do
      let(:params) do
        {
          'ensure'        => 'absent',
          'source_path'   => 'puppet:///site_certs/base.example.org',
        }
      end

      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').with_ensure('absent')
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_ensure('absent')
      }
    end

    context 'with ensure => absent and dhparam => true' do
      let(:params) do
        {
          'dhparam'       => true,
          'ensure'        => 'absent',
          'source_path'   => 'puppet:///site_certs/base.example.org',
        }
      end

      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').with_ensure('absent')
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_ensure('absent')
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org_dh2048.pem').with_ensure('absent')
      }
    end

    context 'with CA cert content' do
      let(:params) do
        {
          'ca_cert'       => true,
          'ca_content'    => 'ca2222',
          'ca_name'       => 'ca',
          'cert_content'  => 'cert1111',
          'key_content'   => 'key1111',
        }
      end

      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').with_content(%r{cert1111})
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_content(%r{key1111})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/ca.crt').with_content(%r{ca2222})
      }
    end

    context 'with CA cert and just source_path' do
      let(:params) do
        {
          'ca_cert'       => true,
          'ca_name'       => 'ca',
          'source_path'   => 'puppet:///site_certs/base.example.org',
        }
      end

      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.crt})
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.key})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/ca.crt')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/ca\.crt})
      }
    end

    context 'with CA cert and ca_source_path' do
      let(:params) do
        {
          'ca_cert'        => true,
          'ca_name'        => 'ca',
          'ca_source_path' => 'puppet:///site_certs',
          'source_path'    => 'puppet:///site_certs/base.example.org',
        }
      end

      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.crt})
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.key})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/ca.crt')
          .with_source(%r{puppet:\/\/\/site_certs\/ca\.crt})
      }
    end

    context 'with chain cert content' do
      let(:params) do
        {
          'cert_chain'    => true,
          'cert_content'  => 'cert1111',
          'chain_content' => 'chain3333',
          'chain_name'    => 'chain',
          'key_content'   => 'key1111',
        }
      end

      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').with_content(%r{cert1111})
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_content(%r{key1111})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/chain.crt').with_content(%r{chain3333})
      }
    end

    context 'with chain cert and just source_path' do
      let(:params) do
        {
          'cert_chain'    => true,
          'chain_name'    => 'chain',
          'source_path'   => 'puppet:///site_certs/base.example.org',
        }
      end

      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.crt})
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.key})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/chain.crt')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/chain\.crt})
      }
    end

    context 'with chain cert and chain_source_path' do
      let(:params) do
        {
          'cert_chain'        => true,
          'chain_name'        => 'chain',
          'chain_source_path' => 'puppet:///site_certs',
          'source_path'       => 'puppet:///site_certs/base.example.org',
        }
      end

      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.crt})
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.key})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/chain.crt')
          .with_source(%r{puppet:\/\/\/site_certs\/chain\.crt})
      }
    end

    context 'with merge_chain => true with CA content' do
      let(:params) do
        {
          'ca_cert'       => true,
          'ca_content'    => 'ca2222',
          'ca_name'       => 'ca',
          'cert_content'  => 'cert1111',
          'key_content'   => 'key1111',
          'merge_chain'   => true,
        }
      end

      it {
        is_expected.to contain_concat('base.example.org_cert_merged')
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_certificate').with_content(%r{cert1111})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_ca').with_content(%r{ca2222})
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_content(%r{key1111})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/ca.crt').with_content(%r{ca2222})
      }

      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_chain')
      }
      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_dhparam')
      }
    end

    context 'with merge_chain => true, with CA, with source paths' do
      let(:params) do
        {
          'ca_cert'        => true,
          'ca_name'        => 'ca',
          'ca_source_path' => 'puppet:///site_certs',
          'merge_chain'    => true,
          'source_path'    => 'puppet:///site_certs/base.example.org',
        }
      end

      it {
        is_expected.to contain_concat('base.example.org_cert_merged')
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_certificate')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.crt})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_ca')
          .with_source(%r{puppet:\/\/\/site_certs\/ca\.crt})
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.key})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/ca.crt')
          .with_source(%r{puppet:\/\/\/site_certs\/ca\.crt})
      }

      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_chain')
      }
      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_dhparam')
      }
    end

    context 'with merge_chain => true, with chain, with content' do
      let(:params) do
        {
          'cert_chain'    => true,
          'cert_content'  => 'cert1111',
          'chain_content' => 'chain3333',
          'chain_name'    => 'chain',
          'key_content'   => 'key1111',
          'merge_chain'   => true,
        }
      end

      it {
        is_expected.to contain_concat('base.example.org_cert_merged')
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_certificate').with_content(%r{cert1111})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_chain').with_content(%r{chain3333})
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_content(%r{key1111})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/chain.crt').with_content(%r{chain3333})
      }

      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_ca')
      }
      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_dhparam')
      }
    end

    context 'with merge_chain => true, with chain, with source paths' do
      let(:params) do
        {
          'cert_chain'        => true,
          'chain_name'        => 'chain',
          'chain_source_path' => 'puppet:///site_certs',
          'merge_chain'       => true,
          'source_path'       => 'puppet:///site_certs/base.example.org',
        }
      end

      it {
        is_expected.to contain_concat('base.example.org_cert_merged')
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_certificate')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.crt})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_chain')
          .with_source(%r{puppet:\/\/\/site_certs\/chain\.crt})
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.key})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/chain.crt')
          .with_source(%r{puppet:\/\/\/site_certs\/chain\.crt})
      }

      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_ca')
      }
      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_dhparam')
      }
    end

    context 'with merge_chain => true, with CA and chain, with contents' do
      let(:params) do
        {
          'ca_cert'       => true,
          'ca_content'    => 'ca2222',
          'ca_name'       => 'ca',
          'cert_content'  => 'cert1111',
          'cert_chain'    => true,
          'chain_content' => 'chain3333',
          'chain_name'    => 'chain',
          'key_content'   => 'key1111',
          'merge_chain'   => true,
        }
      end

      it {
        is_expected.to contain_concat('base.example.org_cert_merged')
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_certificate').with_content(%r{cert1111})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_ca').with_content(%r{ca2222})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_chain').with_content(%r{chain3333})
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_content(%r{key1111})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/ca.crt').with_content(%r{ca2222})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/chain.crt').with_content(%r{chain3333})
      }
      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_dhparam')
      }
    end

    context 'with merge_chain => true, with CA and chain, with sources' do
      let(:params) do
        {
          'ca_cert'           => true,
          'ca_name'           => 'ca',
          'ca_source_path'    => 'puppet:///site_certs',
          'cert_chain'        => true,
          'chain_name'        => 'chain',
          'chain_source_path' => 'puppet:///site_certs',
          'merge_chain'       => true,
          'source_path'       => 'puppet:///site_certs/base.example.org',
        }
      end

      it {
        is_expected.to contain_concat('base.example.org_cert_merged')
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_certificate')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.crt})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_ca')
          .with_source(%r{puppet:\/\/\/site_certs\/ca\.crt})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_chain')
          .with_source(%r{puppet:\/\/\/site_certs\/chain\.crt})
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.key})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/ca.crt')
          .with_source(%r{puppet:\/\/\/site_certs\/ca\.crt})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/chain.crt')
          .with_source(%r{puppet:\/\/\/site_certs\/chain\.crt})
      }

      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_dhparam')
      }
    end

    context 'with merge_dhparam => true, with content' do
      let(:params) do
        {
          'cert_content'    => 'cert1111',
          'dhparam'         => true,
          'dhparam_content' => 'dh4444',
          'key_content'     => 'key1111',
          'merge_dhparam'   => true,
        }
      end

      it {
        is_expected.to contain_concat('base.example.org_cert_merged')
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_certificate').with_content(%r{cert1111})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_dhparam').with_content(%r{dh4444})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org_dh2048.pem').with_content(%r{dh4444})
      }

      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_ca')
      }
      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_chain')
      }
    end

    context 'with merge_dhparam => true, with source' do
      let(:params) do
        {
          'dhparam'         => true,
          'merge_dhparam'   => true,
          'source_path'     => 'puppet:///site_certs/base.example.org',
        }
      end

      it {
        is_expected.to contain_concat('base.example.org_cert_merged')
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_certificate')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.crt})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_dhparam')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/dh2048\.pem})
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.key})
      }

      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_ca')
      }
      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_chain')
      }
    end

    context 'with merge_dhparam => true, but dhparam => false' do
      let(:params) do
        {
          'dhparam'         => false,
          'dhparam_content' => 'dh4444',
          'merge_dhparam'   => true,
          'source_path'     => 'puppet:///site_certs/base.example.org',
        }
      end

      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key')
      }
      it {
        is_expected.to contain_concat('base.example.org_cert_merged')
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_certificate')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.crt})
      }

      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_ca')
      }
      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_chain')
      }
      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_dhparam')
      }
    end

    context 'with merge_chain => true and merge_dhparam => true, with CA, chain, and dhparam contents' do
      let(:params) do
        {
          'ca_cert'         => true,
          'ca_content'      => 'ca2222',
          'ca_name'         => 'ca',
          'cert_chain'      => true,
          'cert_content'    => 'cert1111',
          'chain_content'   => 'chain3333',
          'chain_name'      => 'chain',
          'dhparam'         => true,
          'dhparam_content' => 'dh4444',
          'key_content'     => 'key1111',
          'merge_chain'     => true,
          'merge_dhparam'   => true,
        }
      end

      it {
        is_expected.to contain_concat('base.example.org_cert_merged')
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_certificate').with_content(%r{cert1111})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_ca').with_content(%r{ca2222})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_chain').with_content(%r{chain3333})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_dhparam').with_content(%r{dh4444})
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_content(%r{key1111})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/ca.crt').with_content(%r{ca2222})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/chain.crt').with_content(%r{chain3333})
      }
    end

    context 'with merge_chain => true and merge_dhparam => true, with CA, chain, and dhparam sources' do
      let(:params) do
        {
          'ca_cert'           => true,
          'ca_name'           => 'ca',
          'ca_source_path'    => 'puppet:///site_certs',
          'cert_chain'        => true,
          'chain_name'        => 'chain',
          'chain_source_path' => 'puppet:///site_certs',
          'dhparam'           => true,
          'merge_chain'       => true,
          'merge_dhparam'     => true,
          'source_path'       => 'puppet:///site_certs/base.example.org',
        }
      end

      it {
        is_expected.to contain_concat('base.example.org_cert_merged')
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_certificate')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.crt})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_ca')
          .with_source(%r{puppet:\/\/\/site_certs\/ca\.crt})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_chain')
          .with_source(%r{puppet:\/\/\/site_certs\/chain\.crt})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_dhparam')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/dh2048\.pem})
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.key})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/ca.crt')
          .with_source(%r{puppet:\/\/\/site_certs\/ca\.crt})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/chain.crt')
          .with_source(%r{puppet:\/\/\/site_certs\/chain\.crt})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org_dh2048.pem')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/dh2048\.pem})
      }
    end

    context 'with merge_chain => false, merge_key => true, without chain, CA, or dhparam, with contents' do
      let(:params) do
        {
          'cert_content'  => 'cert1111',
          'key_content'   => 'key1111',
          'merge_chain'   => false,
          'merge_key'     => true,
        }
      end

      it {
        is_expected.to contain_concat('base.example.org_cert_merged')
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_certificate').with_content(%r{cert1111})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_key').with_content(%r{key1111})
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_content(%r{key1111})
      }

      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_ca')
      }
      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_chain')
      }
      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_dhparam')
      }
    end

    context 'with merge_chain => true, merge_key => true, with chain, with contents' do
      let(:params) do
        {
          'cert_chain'    => true,
          'cert_content'  => 'cert1111',
          'chain_content' => 'chain3333',
          'chain_name'    => 'chain',
          'key_content'   => 'key1111',
          'merge_chain'   => true,
          'merge_key'     => true,
        }
      end

      it {
        is_expected.to contain_concat('base.example.org_cert_merged')
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_certificate').with_content(%r{cert1111})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_key').with_content(%r{key1111})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_chain').with_content(%r{chain3333})
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_content(%r{key1111})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/chain.crt').with_content(%r{chain3333})
      }

      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_ca')
      }
      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_dhparam')
      }
    end

    context 'with merge_chain => false, merge_key => true, with chain and CA, with contents' do
      let(:params) do
        {
          'ca_cert'       => true,
          'ca_content'    => 'ca2222',
          'ca_name'       => 'ca',
          'cert_chain'    => true,
          'cert_content'  => 'cert1111',
          'chain_content' => 'chain3333',
          'chain_name'    => 'chain',
          'key_content'   => 'key1111',
          'merge_chain'   => false,
          'merge_key'     => true,
        }
      end

      it {
        is_expected.to contain_concat('base.example.org_cert_merged')
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_certificate').with_content(%r{cert1111})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_key').with_content(%r{key1111})
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_content(%r{key1111})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/ca.crt').with_content(%r{ca2222})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/chain.crt').with_content(%r{chain3333})
      }

      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_ca')
      }
      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_chain')
      }
      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_dhparam')
      }
    end

    context 'with merge_chain => true, merge_key => true, with CA and chain, with contents' do
      let(:params) do
        {
          'ca_cert'       => true,
          'ca_content'    => 'ca2222',
          'ca_name'       => 'ca',
          'cert_chain'    => true,
          'cert_content'  => 'cert1111',
          'chain_content' => 'chain3333',
          'chain_name'    => 'chain',
          'key_content'   => 'key1111',
          'merge_chain'   => true,
          'merge_key'     => true,
        }
      end

      it {
        is_expected.to contain_concat('base.example.org_cert_merged')
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_certificate').with_content(%r{cert1111})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_key').with_content(%r{key1111})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_ca').with_content(%r{ca2222})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_chain').with_content(%r{chain3333})
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_content(%r{key1111})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/ca.crt').with_content(%r{ca2222})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/chain.crt').with_content(%r{chain3333})
      }

      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_dhparam')
      }
    end

    context 'with merge_chain => true, merge_key => true, with CA, chain and dhparam, with contents' do
      let(:params) do
        {
          'ca_cert'         => true,
          'ca_content'      => 'ca2222',
          'ca_name'         => 'ca',
          'cert_chain'      => true,
          'cert_content'    => 'cert1111',
          'chain_content'   => 'chain3333',
          'chain_name'      => 'chain',
          'dhparam'         => true,
          'dhparam_content' => 'dh4444',
          'key_content'     => 'key1111',
          'merge_chain'     => true,
          'merge_dhparam'   => true,
          'merge_key'       => true,
        }
      end

      it {
        is_expected.to contain_concat('base.example.org_cert_merged')
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_certificate').with_content(%r{cert1111})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_key').with_content(%r{key1111})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_ca').with_content(%r{ca2222})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_chain').with_content(%r{chain3333})
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_dhparam').with_content(%r{dh4444})
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_content(%r{key1111})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/ca.crt').with_content(%r{ca2222})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/chain.crt').with_content(%r{chain3333})
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org_dh2048.pem').with_content(%r{dh4444})
      }
    end

    context 'with dhparam file' do
      let(:params) do
        {
          'dhparam'       => true,
          'source_path'   => 'puppet:///site_certs/base.example.org',
        }
      end

      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org_dh2048.pem')
      }
    end

    context 'with dhparam file and custom directory' do
      let(:params) do
        {
          'dhparam'       => true,
          'dhparam_dir'   => '/tmp/dir',
          'source_path'   => 'puppet:///site_certs/base.example.org',
        }
      end

      it {
        is_expected.to contain_file('/tmp/dir/base.example.org_dh2048.pem')
      }
    end

    context 'with dhparam file, with ensure => absent' do
      let(:params) do
        {
          'dhparam'       => true,
          'ensure'        => 'absent',
          'source_path'   => 'puppet:///site_certs/base.example.org',
        }
      end

      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org_dh2048.pem').with_ensure('absent')
      }
    end

    context 'with dhparam file with source_path' do
      let(:params) do
        {
          'dhparam'       => true,
          'source_path'   => 'puppet:///site_certs/base.example.org',
        }
      end

      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org_dh2048.pem')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/dh2048\.pem})
      }
    end

    context 'with dhparam file with contents overriding source_path' do
      let(:params) do
        {
          'dhparam'         => true,
          'dhparam_content' => 'dh4444',
          'source_path'     => 'puppet:///site_certs/base.example.org',
        }
      end

      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org_dh2048.pem').with_content(%r{dh4444})
      }
    end

    context 'with dhparam file with custom name' do
      let(:params) do
        {
          'dhparam'       => true,
          'dhparam_file'  => 'dhparam.crt',
          'source_path'   => 'puppet:///site_certs/base.example.org',
        }
      end

      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org_dhparam.crt')
          .with_source(%r{puppet:\/\/\/site_certs\/base.example.org\/dhparam\.crt})
      }
    end

    context 'with a custom user set' do
      let(:params) do
        {
          'ca_cert'       => true,
          'ca_content'    => 'ca2222',
          'ca_name'       => 'ca',
          'cert_chain'    => true,
          'cert_content'  => 'cert1111',
          'chain_content' => 'chain3333',
          'chain_name'    => 'chain',
          'dhparam'       => true,
          'key_content'   => 'key1111',
          'owner'         => 'newowner',
        }
      end

      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').with_owner('newowner')
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_owner('newowner')
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/ca.crt').with_owner('newowner')
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/chain.crt').with_owner('newowner')
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org_dh2048.pem').with_owner('newowner')
      }
    end

    context 'with a custom group set' do
      let(:params) do
        {
          'ca_cert'       => true,
          'ca_content'    => 'ca2222',
          'ca_name'       => 'ca',
          'cert_chain'    => true,
          'cert_content'  => 'cert1111',
          'chain_content' => 'chain3333',
          'chain_name'    => 'chain',
          'dhparam'       => true,
          'group'         => 'newgroup',
          'key_content'   => 'key1111',
        }
      end

      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').with_group('newgroup')
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org_dh2048.pem').with_group('newgroup')
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_group('newgroup')
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/ca.crt').with_group('newgroup')
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/chain.crt').with_group('newgroup')
      }
    end

    context 'with a custom file and directory modes set' do
      let(:params) do
        {
          'ca_cert'       => true,
          'ca_content'    => 'ca2222',
          'ca_name'       => 'ca',
          'cert_chain'    => true,
          'cert_content'  => 'cert1111',
          'cert_dir_mode' => '0500',
          'cert_mode'     => '0700',
          'chain_content' => 'chain3333',
          'chain_name'    => 'chain',
          'dhparam'       => true,
          'key_content'   => 'key1111',
          'key_mode'      => '0400',
          'key_dir_mode'  => '0500',
        }
      end

      it {
        is_expected.to contain_file('/etc/ssl/certs').with_ensure('directory')
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs').with_mode('0500')
      }
      it {
        is_expected.to contain_file('/etc/ssl/private').with_ensure('directory')
      }
      it {
        is_expected.to contain_file('/etc/ssl/private').with_mode('0500')
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').with_mode('0700')
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org_dh2048.pem').with_mode('0700')
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_mode('0400')
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/ca.crt').with_mode('0700')
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/chain.crt').with_mode('0700')
      }
    end

    context 'with custom extensions set' do
      let(:params) do
        {
          'ca_cert'       => true,
          'ca_ext'        => '.pem',
          'ca_content'    => 'ca2222',
          'ca_name'       => 'ca',
          'cert_chain'    => true,
          'cert_content'  => 'cert1111',
          'cert_ext'      => '.pem',
          'chain_content' => 'chain3333',
          'chain_ext'     => '.pem',
          'chain_name'    => 'chain',
          'key_content'   => 'key1111',
          'key_ext'       => '.pem',
        }
      end

      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org.pem')
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.pem')
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/ca.pem')
      }
      it {
        is_expected.to contain_file('/etc/ssl/certs/chain.pem')
      }
    end

    context 'with custom source names set' do
      let(:params) do
        {
          'source_cert_name' => 'other_base.example.org',
          'source_key_name'  => 'other_base.example.org',
          'source_path'      => 'puppet:///site_certs/other_base.example.org',
        }
      end

      it {
        is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt')
          .with_source(%r{puppet:\/\/\/site_certs\/other_base.example.org\/other_base\.example\.org\.crt})
      }
      it {
        is_expected.to contain_file('/etc/ssl/private/base.example.org.key')
          .with_source(%r{puppet:\/\/\/site_certs\/other_base.example.org\/other_base\.example\.org\.key})
      }
    end
  end
end
