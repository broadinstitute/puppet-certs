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
                    let(:params) {{
                        :cert_content => 'cert1111',
                        :key_content  => 'key1111',
                        :service      => :undef,
                    }}

                    it { is_expected.to contain_file('/etc/ssl/certs').
                        with_ensure('directory')
                    }
                    it { is_expected.to contain_file('/etc/ssl/private').
                        with_ensure('directory')
                    }
                    it { is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').
                        with_group('root')
                    }
                    it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').
                        with_group('root')
                    }
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
                    let(:params) {{
                        :cert_content => 'cert1111',
                        :key_content  => 'key1111',
                        :service      => :undef,
                    }}

                    it { is_expected.to contain_file('/usr/local/etc/apache24').
                        with_ensure('directory')
                    }
                    it { is_expected.to contain_file('/usr/local/etc/apache24').
                        with_group('wheel')
                    }
                    it { is_expected.to contain_file('/usr/local/etc/apache24/base.example.org.crt').
                        with_group('wheel')
                    }
                    it { is_expected.to contain_file('/usr/local/etc/apache24/base.example.org.key').
                        with_group('wheel')
                    }
                end
            end

            if osfamily == 'Gentoo'
                let(:facts) {{
                    :osfamily               => osfamily,
                    :operatingsystem        => 'Gentoo',
                    :operatingsystemrelease => '3.16.1-gentoo',
                }}

                context 'with only cert and key content set' do
                    let(:params) {{
                        :cert_content => 'cert1111',
                        :key_content  => 'key1111',
                        :service      => :undef,
                    }}

                    it { is_expected.to contain_file('/etc/ssl/apache2').
                        with_ensure('directory')
                    }
                    it { is_expected.to contain_file('/etc/ssl/apache2').
                        with_group('wheel')
                    }
                    it { is_expected.to contain_file('/etc/ssl/apache2/base.example.org.crt').
                        with_group('wheel')
                    }
                    it { is_expected.to contain_file('/etc/ssl/apache2/base.example.org.key').
                        with_group('wheel')
                    }
                end
            end

            if osfamily == 'RedHat'
                let(:facts) {{
                    :osfamily                  => osfamily,
                    :operatingsystem           => 'RedHat',
                    :operatingsystemrelease    => '7.2',
                    :operatingsystemmajrelease => '7',
                }}

                context 'with only cert and key content set' do
                    let(:params) {{
                        :cert_content => 'cert1111',
                        :key_content  => 'key1111',
                        :service      => :undef,
                    }}

                    it { is_expected.to contain_file('/etc/pki/tls/certs').
                        with_ensure('directory')
                    }
                    it { is_expected.to contain_file('/etc/pki/tls/private').
                        with_ensure('directory')
                    }
                    it { is_expected.to contain_file('/etc/pki/tls/certs/base.example.org.crt').
                        with_group('root')
                    }
                    it { is_expected.to contain_file('/etc/pki/tls/private/base.example.org.key').
                        with_group('root')
                    }
                end
            end
        end
    end

    context "on Debian-like setup for the remaining tests" do

        let(:facts) {{
            :osfamily                  => 'Debian',
            :operatingsystem           => 'Debian',
            :lsbdistid                 => 'Debian',
            :lsbdistcodename           => 'wheezy',
            :operatingsystemrelease    => '7.3',
            :operatingsystemmajrelease => '7',
        }}

        # This define requires the certs class, so make sure it's defined
        let :pre_condition do
            'class { "certs": }'
        end

        context 'with only cert and key content set' do
            let(:params) {{
                :cert_content => 'cert1111',
                :key_content  => 'key1111',
                :service      => :undef,
            }}

            it { is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').
                with_content(/cert1111/)
            }
            it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').
                with_content(/key1111/)
            }
        end

        context 'with only cert and key using source_path' do
            let(:params) {{
                :service      => :undef,
                :source_path  => 'puppet:///site_certs/base.example.org',
            }}

            it { is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').
                with_source(/puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.crt/)
            }
            it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').
                with_source(/puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.key/)
            }
        end

        context 'with ensure => absent' do
            let(:params) {{
                :service     => :undef,
                :ensure      => 'absent',
                :source_path => 'puppet:///site_certs/base.example.org',
            }}

            it { is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').
                with_ensure('absent')
            }
            it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').
                with_ensure('absent')
            }
        end

        context 'with ensure => absent and dhparam => true' do
            let(:params) {{
                :service     => :undef,
                :ensure      => 'absent',
                :dhparam     => true,
                :source_path => 'puppet:///site_certs/base.example.org',
            }}

            it { is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').
                with_ensure('absent')
            }
            it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').
                with_ensure('absent')
            }
            it { is_expected.to contain_file('/etc/ssl/certs/base.example.org_dh2048.pem').
                with_ensure('absent')
            }
        end

        context 'with CA cert content' do
            let(:params) {{
                :cert_content => 'cert1111',
                :key_content  => 'key1111',
                :service      => :undef,
                :ca_cert      => true,
                :ca_name      => 'ca',
                :ca_content   => 'ca2222',
                :ensure       => 'present',
            }}

            it { is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').
                with_content(/cert1111/)
            }
            it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').
                with_content(/key1111/)
            }
            it { is_expected.to contain_file('/etc/ssl/certs/ca.crt').
                with_content(/ca2222/)
            }
        end

        context 'with CA cert and just source_path' do
            let(:params) {{
                :service        => :undef,
                :ca_cert        => true,
                :ca_name        => 'ca',
                :ensure         => 'present',
                :source_path    => 'puppet:///site_certs/base.example.org',
            }}

            it { is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').
                with_source(/puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.crt/)
            }
            it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').
                with_source(/puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.key/)
            }
            it { is_expected.to contain_file('/etc/ssl/certs/ca.crt').
                with_source(/puppet:\/\/\/site_certs\/base.example.org\/ca\.crt/)
            }
        end

        context 'with CA cert and ca_source_path' do
            let(:params) {{
                :service        => :undef,
                :ca_cert        => true,
                :ca_name        => 'ca',
                :ensure         => 'present',
                :source_path    => 'puppet:///site_certs/base.example.org',
                :ca_source_path => 'puppet:///site_certs',
            }}

            it { is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').
                with_source(/puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.crt/)
            }
            it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').
                with_source(/puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.key/)
            }
            it { is_expected.to contain_file('/etc/ssl/certs/ca.crt').
                with_source(/puppet:\/\/\/site_certs\/ca\.crt/)
            }
        end

        context 'with chain cert content' do
            let(:params) {{
                :cert_content  => 'cert1111',
                :key_content   => 'key1111',
                :service       => :undef,
                :cert_chain    => true,
                :chain_name    => 'chain',
                :chain_content => 'chain3333',
                :ensure        => 'present'
            }}

            it { is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').
                with_content(/cert1111/)
            }
            it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').
                with_content(/key1111/)
            }
            it { is_expected.to contain_file('/etc/ssl/certs/chain.crt').
                with_content(/chain3333/)
            }
        end

        context 'with chain cert and just source_path' do
            let(:params) {{
                :service     => :undef,
                :cert_chain  => true,
                :chain_name  => 'chain',
                :ensure      => 'present',
                :source_path => 'puppet:///site_certs/base.example.org',
            }}

            it { is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').
                with_source(/puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.crt/)
            }
            it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').
                with_source(/puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.key/)
            }
            it { is_expected.to contain_file('/etc/ssl/certs/chain.crt').
                with_source(/puppet:\/\/\/site_certs\/base.example.org\/chain\.crt/)
            }
        end

        context 'with chain cert and chain_source_path' do
            let(:params) {{
                :service           => :undef,
                :cert_chain        => true,
                :chain_name        => 'chain',
                :ensure            => 'present',
                :source_path       => 'puppet:///site_certs/base.example.org',
                :chain_source_path => 'puppet:///site_certs',
            }}

            it { is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').
                with_source(/puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.crt/)
            }
            it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').
                with_source(/puppet:\/\/\/site_certs\/base.example.org\/base\.example\.org\.key/)
            }
            it { is_expected.to contain_file('/etc/ssl/certs/chain.crt').
                with_source(/puppet:\/\/\/site_certs\/chain\.crt/)
            }
        end

        context 'with merge_chain set to true with CA' do
            let(:params) {{
                :cert_content => 'cert1111',
                :key_content  => 'key1111',
                :service      => :undef,
                :ensure       => 'present',
                :ca_cert      => true,
                :ca_name      => 'ca',
                :ca_content   => 'ca2222',
                :merge_chain  => true
            }}

            it { is_expected.to contain_concat('base.example.org_cert_merged') }
            it { is_expected.to contain_concat__fragment('base.example.org.crt_certificate').
                with_content(/cert1111/)
            }
            it { is_expected.to contain_concat__fragment('base.example.org.crt_ca').
                with_content(/ca2222/)
            }
            it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').
                with_content(/key1111/)
            }
            it { is_expected.to contain_file('/etc/ssl/certs/ca.crt').
                with_content(/ca2222/)
            }
        end

        context 'with merge_chain set to true with chain' do
            let(:params) {{
                :cert_content  => 'cert1111',
                :key_content   => 'key1111',
                :service       => :undef,
                :ensure        => 'present',
                :cert_chain    => true,
                :chain_name    => 'chain',
                :chain_content => 'chain3333',
                :merge_chain   => true
            }}

            it { is_expected.to contain_concat('base.example.org_cert_merged') }
            it { is_expected.to contain_concat__fragment('base.example.org.crt_certificate').
                with_content(/cert1111/)
            }
            it { is_expected.to contain_concat__fragment('base.example.org.crt_chain').
                with_content(/chain3333/)
            }
            it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').
                with_content(/key1111/)
            }
            it { is_expected.to contain_file('/etc/ssl/certs/chain.crt').
                with_content(/chain3333/)
            }
        end

        context 'with merge_chain set to true with CA and chain' do
            let(:params) {{
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
            }}

            it { is_expected.to contain_concat('base.example.org_cert_merged') }
            it { is_expected.to contain_concat__fragment('base.example.org.crt_certificate').
                with_content(/cert1111/)
            }
            it { is_expected.to contain_concat__fragment('base.example.org.crt_ca').
                with_content(/ca2222/)
            }
            it { is_expected.to contain_concat__fragment('base.example.org.crt_chain').
                with_content(/chain3333/)
            }
            it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').
                with_content(/key1111/)
            }
            it { is_expected.to contain_file('/etc/ssl/certs/ca.crt').
                with_content(/ca2222/)
            }
            it { is_expected.to contain_file('/etc/ssl/certs/chain.crt').
                with_content(/chain3333/)
            }
        end

        context 'with merge_chain set to false and merge_key set to true with neither chain nor CA' do
            let(:params) {{
                :cert_content  => 'cert1111',
                :key_content   => 'key1111',
                :service       => :undef,
                :ensure        => 'present',
                :merge_chain   => false,
                :merge_key     => true
            }}

            it { is_expected.to contain_concat('base.example.org_cert_merged') }
            it { is_expected.to contain_concat__fragment('base.example.org.crt_certificate').
                with_content(/cert1111/)
            }
            it { is_expected.to contain_concat__fragment('base.example.org.crt_key').
                with_content(/key1111/)
            }
            it { is_expected.not_to contain_concat__fragment('base.example.org.crt_ca') }
            it { is_expected.not_to contain_concat__fragment('base.example.org.crt_chain') }
            it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').
                with_content(/key1111/)
            }
        end

        context 'with merge_chain set to false and merge_key set to true with chain and CA set' do
            let(:params) {{
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
                :merge_chain   => false,
                :merge_key     => true
            }}

            it { is_expected.to contain_concat('base.example.org_cert_merged') }
            it { is_expected.to contain_concat__fragment('base.example.org.crt_certificate').
                with_content(/cert1111/)
            }
            it { is_expected.to contain_concat__fragment('base.example.org.crt_key').
                with_content(/key1111/)
            }
            it { is_expected.not_to contain_concat__fragment('base.example.org.crt_ca') }
            it { is_expected.not_to contain_concat__fragment('base.example.org.crt_chain') }
            it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').
                with_content(/key1111/)
            }
            it { is_expected.to contain_file('/etc/ssl/certs/ca.crt').
                with_content(/ca2222/)
            }
            it { is_expected.to contain_file('/etc/ssl/certs/chain.crt').
                with_content(/chain3333/)
            }
        end

        context 'with merge_chain and merge_key set to true with chain' do
            let(:params) {{
                :cert_content  => 'cert1111',
                :key_content   => 'key1111',
                :service       => :undef,
                :ensure        => 'present',
                :cert_chain    => true,
                :chain_name    => 'chain',
                :chain_content => 'chain3333',
                :merge_chain   => true,
                :merge_key     => true
            }}

            it { is_expected.to contain_concat('base.example.org_cert_merged') }
            it { is_expected.to contain_concat__fragment('base.example.org.crt_certificate').
                with_content(/cert1111/)
            }
            it { is_expected.to contain_concat__fragment('base.example.org.crt_key').
                with_content(/key1111/)
            }
            it {is_expected.to contain_concat__fragment('base.example.org.crt_chain').
                with_content(/chain3333/)
            }
            it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').
                with_content(/key1111/)
            }
            it { is_expected.to contain_file('/etc/ssl/certs/chain.crt').
                with_content(/chain3333/)
            }
        end

        context 'with merge_chain and merge_key set to true with CA and chain' do
            let(:params) {{
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
                :merge_chain   => true,
                :merge_key     => true
            }}

            it { is_expected.to contain_concat('base.example.org_cert_merged') }
            it { is_expected.to contain_concat__fragment('base.example.org.crt_certificate').
                with_content(/cert1111/)
            }
            it { is_expected.to contain_concat__fragment('base.example.org.crt_key').
                with_content(/key1111/)
            }
            it { is_expected.to contain_concat__fragment('base.example.org.crt_ca').
                with_content(/ca2222/)
            }
            it { is_expected.to contain_concat__fragment('base.example.org.crt_chain').
                with_content(/chain3333/)
            }
            it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').
                with_content(/key1111/)
            }
            it { is_expected.to contain_file('/etc/ssl/certs/ca.crt').
                with_content(/ca2222/)
            }
            it { is_expected.to contain_file('/etc/ssl/certs/chain.crt').
                with_content(/chain3333/)
            }
        end

        context 'with dhparam file' do
            let(:params) {{
                :service     => :undef,
                :ensure      => 'present',
                :dhparam     => true,
                :source_path => 'puppet:///site_certs/base.example.org',
            }}

            it { is_expected.to contain_file('/etc/ssl/certs/base.example.org_dh2048.pem') }
        end

        context 'with dhparam file, with ensure => absent' do
            let(:params) {{
                :service     => :undef,
                :ensure      => 'absent',
                :dhparam     => true,
                :source_path => 'puppet:///site_certs/base.example.org',
            }}

            it { is_expected.to contain_file('/etc/ssl/certs/base.example.org_dh2048.pem').
                with_ensure('absent')
            }
        end

        context 'with dhparam file with contents overriding source_path' do
            let(:params) {{
                :service         => :undef,
                :ensure          => 'present',
                :dhparam         => true,
                :dhparam_content => 'dh4444',
                :source_path     => 'puppet:///site_certs/base.example.org',
            }}

            it { is_expected.to contain_file('/etc/ssl/certs/base.example.org_dh2048.pem').
                with_content(/dh4444/)
            }
        end

        context 'with dhparam file with source_path' do
            let(:params) {{
                :service         => :undef,
                :ensure          => 'present',
                :dhparam         => true,
                :source_path     => 'puppet:///site_certs/base.example.org',
            }}

            it { is_expected.to contain_file('/etc/ssl/certs/base.example.org_dh2048.pem').
                with_source(/puppet:\/\/\/site_certs\/base.example.org\/dh2048\.pem/)
            }
        end

        context 'with dhparam file with custom name' do
            let(:params) {{
                :service      => :undef,
                :ensure       => 'present',
                :dhparam      => true,
                :dhparam_file => 'dhparam.crt',
                :source_path  => 'puppet:///site_certs/base.example.org',
            }}

            it { is_expected.to contain_file('/etc/ssl/certs/base.example.org_dhparam.crt').
                with_source(/puppet:\/\/\/site_certs\/base.example.org\/dhparam\.crt/)
            }
        end

        context 'with a custom user set' do
            let(:params) {{
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
                :dhparam       => true,
                :owner         => 'newowner',
            }}

            it { is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').
                with_owner('newowner')
            }
            it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').
                with_owner('newowner')
            }
            it { is_expected.to contain_file('/etc/ssl/certs/ca.crt').
                with_owner('newowner')
            }
            it { is_expected.to contain_file('/etc/ssl/certs/chain.crt').
                with_owner('newowner')
            }
            it { is_expected.to contain_file('/etc/ssl/certs/base.example.org_dh2048.pem').
                with_owner('newowner')
            }
        end

        context 'with a custom group set' do
            let(:params) {{
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
                :dhparam       => true,
                :group         => 'newgroup',
            }}

            it { is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').
                with_group('newgroup')
            }
            it { is_expected.to contain_file('/etc/ssl/certs/base.example.org_dh2048.pem').
                with_group('newgroup')
            }
            it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').
                with_group('newgroup')
            }
            it { is_expected.to contain_file('/etc/ssl/certs/ca.crt').
                with_group('newgroup')
            }
            it { is_expected.to contain_file('/etc/ssl/certs/chain.crt').
                with_group('newgroup')
            }
        end

        context 'with a custom file and directory modes set' do
            let(:params) {{
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
                :dhparam       => true,
            }}

            it { is_expected.to contain_file('/etc/ssl/certs').
                with_ensure('directory')
            }
            it { is_expected.to contain_file('/etc/ssl/certs').
                with_mode('0500')
            }
            it { is_expected.to contain_file('/etc/ssl/private').
                with_ensure('directory')
            }
            it { is_expected.to contain_file('/etc/ssl/private').
                with_mode('0500')
            }
            it { is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').
                with_mode('0700')
            }
            it { is_expected.to contain_file('/etc/ssl/certs/base.example.org_dh2048.pem').
                with_mode('0700')
            }
            it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').
                with_mode('0400')
            }
            it { is_expected.to contain_file('/etc/ssl/certs/ca.crt').
                with_mode('0700')
            }
            it { is_expected.to contain_file('/etc/ssl/certs/chain.crt').
                with_mode('0700')
            }
        end

        context 'with custom extensions set' do
            let(:params) {{
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
            }}

            it { is_expected.to contain_file('/etc/ssl/certs/base.example.org.pem') }
            it { is_expected.to contain_file('/etc/ssl/private/base.example.org.pem') }
            it { is_expected.to contain_file('/etc/ssl/certs/ca.pem') }
            it { is_expected.to contain_file('/etc/ssl/certs/chain.pem') }
        end
    end
end
