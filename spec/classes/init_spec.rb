require 'spec_helper'

describe 'certificates', type: :class do
  ['Debian', 'FreeBSD', 'Gentoo', 'RedHat'].each do |osfamily|
    context "on #{osfamily}" do
      if osfamily == 'Debian'
        let(:facts) do
          {
            'osfamily'                  => 'Debian',
            'operatingsystem'           => 'Debian',
            'lsbdistid'                 => 'Debian',
            'lsbdistcodename'           => 'wheezy',
            'operatingsystemrelease'    => '7.3',
            'operatingsystemmajrelease' => '7',
          }
        end

        context 'with defaults for all parameters' do
          it { is_expected.to contain_class('certificates') }
        end
      end

      if osfamily == 'FreeBSD'
        let(:facts) do
          {
            'osfamily'                  => osfamily,
            'operatingsystem'           => 'FreeBSD',
            'operatingsystemrelease'    => '10.0-RELEASE-p18',
            'operatingsystemmajrelease' => '10',
          }
        end

        context 'with defaults for all parameters' do
          it { is_expected.to contain_class('certificates') }
        end
      end

      if osfamily == 'Gentoo'
        let(:facts) do
          {
            'osfamily'               => osfamily,
            'operatingsystem'        => 'Gentoo',
            'operatingsystemrelease' => '3.16.1-gentoo',
          }
        end

        context 'with defaults for all parameters' do
          it { is_expected.to contain_class('certificates') }
        end
      end

      if osfamily == 'RedHat'
        let(:facts) do
          {
            'osfamily'                  => osfamily,
            'operatingsystem'           => 'RedHat',
            'operatingsystemrelease'    => '7.2',
            'operatingsystemmajrelease' => '7',
          }
        end

        context 'with defaults for all parameters' do
          it { is_expected.to contain_class('certificates') }
        end
      end
    end
  end
end
