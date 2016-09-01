require 'spec_helper'

describe 'certs', :type => :class do

  [ 'Debian', 'RedHat' ].each do |osfamily|

    context "on #{osfamily}" do

      if osfamily == 'Debian'
        let(:facts) { {
          :osfamily               => 'Debian',
          :operatingsystem        => 'Debian',
          :lsbdistid              => 'Debian',
          :lsbdistcodename        => 'wheezy',
          :kernelrelease          => '3.2.0-4-amd64',
          :operatingsystemrelease => '7.3',
          :operatingsystemmajrelease => '7',
        } }

        context 'with defaults for all parameters' do
          it { should contain_class('certs') }
        end
      end

      if osfamily == 'RedHat'
        let(:facts) { {
          :osfamily => osfamily,
          :operatingsystem => 'RedHat',
          :operatingsystemrelease => '7.2',
          :operatingsystemmajrelease => '7',
        } }

        context 'with defaults for all parameters' do
          it { should contain_class('certs') }
        end
      end

    end
  end
end
