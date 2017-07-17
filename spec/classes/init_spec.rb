require 'spec_helper'

describe 'certs', :type => :class do

    [ 'Debian', 'FreeBSD', 'Gentoo', 'RedHat' ].each do |osfamily|

        context "on #{osfamily}" do

            if osfamily == 'Debian'
                let(:facts) {{
                    :osfamily               => 'Debian',
                    :operatingsystem        => 'Debian',
                    :lsbdistid              => 'Debian',
                    :lsbdistcodename        => 'wheezy',
                    :operatingsystemrelease => '7.3',
                    :operatingsystemmajrelease => '7',
                }}

                context 'with defaults for all parameters' do
                    it { is_expected.to contain_class('certs') }
                end
            end

            if osfamily == 'FreeBSD'
                let(:facts) {{
                    :osfamily => osfamily,
                    :operatingsystem => 'FreeBSD',
                    :operatingsystemrelease => '10.0-RELEASE-p18',
                    :operatingsystemmajrelease => '10',
                }}

                context 'with defaults for all parameters' do
                    it { is_expected.to contain_class('certs') }
                end
            end

            if osfamily == 'Gentoo'
                let(:facts) {{
                    :osfamily => osfamily,
                    :operatingsystem => 'Gentoo',
                    :operatingsystemrelease => '3.16.1-gentoo',
                }}

                context 'with defaults for all parameters' do
                    it { is_expected.to contain_class('certs') }
                end
            end

            if osfamily == 'RedHat'
                let(:facts) {{
                    :osfamily => osfamily,
                    :operatingsystem => 'RedHat',
                    :operatingsystemrelease => '7.2',
                    :operatingsystemmajrelease => '7',
                }}

                context 'with defaults for all parameters' do
                    it { is_expected.to contain_class('certs') }
                end
            end
        end
    end
end
