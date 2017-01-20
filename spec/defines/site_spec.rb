require 'spec_helper'

describe 'certs::site', :type => :define do
  # rubocop:disable Lint/IndentHeredoc : Heredoc's are meant to be indented in this way

  let(:title) { 'base.example.org' }

  let(:valid_cert) do
    <<DOC
-----BEGIN CERTIFICATE-----
MIIC9jCCAeCgAwIBAgIRAK11n3X7aypJ7FPM8UFyAeowCwYJKoZIhvcNAQELMBIx
EDAOBgNVBAoTB0FjbWUgQ28wHhcNMTUxMTIzMjIzOTU4WhcNMTYxMTIyMjIzOTU4
WjASMRAwDgYDVQQKEwdBY21lIENvMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAz9bY/piKahD10AiJSfbI2A8NG5UwRz0r9T/WfvNVdhgrsGFgNQjvpUoZ
nNJpQIHBbgMOiXqfATFjJl5FjEkSf7GUHohlGVls9MX2JmVvknzsiitd75H/EJd+
N+k915lix8Vqmj8d1CTlbF/8tEjzANI67Vqw5QTuqebO7rkIUvRg6yiRfSo75FK1
RinCJyl++kmleBwQZBInQyg95GvJ5JTqMzBs67DeeyzskDhTeTePRYVF2NwL8QzY
htvLIBERTNsyU5i7nkxY5ptUwgFUwd93LH4Q19tPqL5C5RZqXxhE51thOOwafm+a
W/cRkqYqV+tv+j1jJ3WICyF1JNW0BQIDAQABo0swSTAOBgNVHQ8BAf8EBAMCAKAw
EwYDVR0lBAwwCgYIKwYBBQUHAwEwDAYDVR0TAQH/BAIwADAUBgNVHREEDTALggls
b2NhbGhvc3QwCwYJKoZIhvcNAQELA4IBAQAzRo0hpVTrFQZLIXpwvKwZVGvJdCkV
P95DTsSk/VTGV+/YtxrRqks++hJZnctm2PbnTsCAoIP3AMx+vicCKiKrxvpsLU8/
+6cowUbcuGMdSQktwDqbAgEhQlLsETll06w1D/KC+ejOc4+LRn3GQcEyGDtMk/EX
IeAvBZHr4/kVXWnfo6kzCLcku1f8yE/yDEFClZe9XV1Lk/s+3YfXVtNnMJJ1giZI
QVOe6CkmuQq+4AtIeW8aLkvlfp632jag1F77a1y+L268koKkj0hBMrtcErVQaxmq
xym0+soR4Tk4pTIGckeFglrLxkP2JpM/yTwSEAVlmG9vgTliYKyR0uMl
-----END CERTIFICATE-----
DOC
  end

  let(:valid_key) do
    <<DOC
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAz9bY/piKahD10AiJSfbI2A8NG5UwRz0r9T/WfvNVdhgrsGFg
NQjvpUoZnNJpQIHBbgMOiXqfATFjJl5FjEkSf7GUHohlGVls9MX2JmVvknzsiitd
75H/EJd+N+k915lix8Vqmj8d1CTlbF/8tEjzANI67Vqw5QTuqebO7rkIUvRg6yiR
fSo75FK1RinCJyl++kmleBwQZBInQyg95GvJ5JTqMzBs67DeeyzskDhTeTePRYVF
2NwL8QzYhtvLIBERTNsyU5i7nkxY5ptUwgFUwd93LH4Q19tPqL5C5RZqXxhE51th
OOwafm+aW/cRkqYqV+tv+j1jJ3WICyF1JNW0BQIDAQABAoIBADAiZ/r+xP+vkd5u
O61/lCBFzBlZQecdybJw6HJaVK6XBndA9hESUr4LHUdui6W+51ddKd65IV4bXAUk
zCKjQb+FFvLDT/bA+TTvLATUdTSN7hJJ3OWBAHuNOlQklof6JCB0Hi4+89+P8/pX
eKUgR/cmuTMDT/iaXdPHeqFbBQyA1ZpQFRjN5LyyJMS/9FkywuNc5wlpsArtc51T
gIKENUZCuPhosR+kMFc2iuTNvqZWPhvouSrmhi2O6nSqV+oy0+irlqSpCF2GsCI8
72TtLpq94Grrq0BEH5avouV+Lp4k83vO65OKCQKUFQlxz3Xkxm2U3J7KzxqnRtM3
/b+cJ/kCgYEA6/yOnaEYhH/7ijhZbPn8RujXZ5VGJXKJqIuaPiHMmHVS5p1j6Bah
2PcnqJA2IlLs3UloN+ziAxAIH6KCBiwlQ/uPBNMMaJsIjPNBEy8axjndKhKUpidg
R0OJ7RQqMShOJ8akrSfWdPtXC/GBuwCYE//t77GgZaIMO3FcT9EKA48CgYEA4Xcx
Fia0Jg9iyAhNmUOXI6hWcGENavMx01+x7XFhbnMjIKTZevFfTnTkrX6HyLXyGtMU
gHOn+k4PE/purI4ARrKO8m5wYEKqSIt4dBMTkIXXirfQjXgfjR8E4T/aPe5fOFZo
7OYuxLRtzmG1C2sW4txwKAKX1LaWcVx/RLSttSsCgYBbcj8Brk+F6OJcqYFdzXGJ
OOlf5mSMVlopyg83THmwCqbZXtw8L6kAHqZrl5airmfDSJLuOQlMDoZXW+3u3mSC
d5TwVahVUN57YDgzaumBLyMZDqIz0MZqVy23hTzkV64Rk9R0lR9xrYQJyMhw4sYL
2f0mCTsSpzz+O+t9so+i2QKBgEC38gMlwPhb2kMI/x1LZYr6uzUu5qcYf+jowy4h
KZKGwkKQj0zXFEB1FV8nvtpCP+irRmtIx6L13SYi8LnfWPzyLE4ynVdES5TfVAgd
obQOdzx+XwL8xDHCAaiWp5K3ZeXKB/xYZnxYPlzLdyh76Ond1OPnOqX4c16+6llS
c7pZAoGATd9NckT0XtXLEsF3IraDivq8dP6bccX2DNfS8UeEvRRrRwpFpSRrmuGb
jbG4yzoIX4RjQfj/z48hwhJB+cKiN9WwcPsFXtHe7v3F6BRwK0JUfrCiXad8/SGZ
KAf7Dfqi608zBdnPWHacre2Y35gPHB00nFQOLS6u46aBNSq07YA=
-----END RSA PRIVATE KEY-----
DOC
  end

  let(:another_valid_key) do
    <<DOC
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAoISxYJBTPAeAzFnm+lE/ljLlmGal2Xr3vwZKkvJiuKA/m4QJ
0ZNdtkBSDOVuG2dXVv6W4sChRtsCdvuVe7bjTYvlU8TWM3VEJDL9l9cRXScxxlKQ
Xwb35y1yV35NJfaK/jzm9KcErtQQs1RxvGlWRaohmLM8uQcuhjZfMsSlQoHQD5LX
sbPtk82RPyxYc1dj2vsaoi1VvuP2+jv4xLQOmNJY1bT5GTurqiltmxEtWhNNmGg0
2wtK00ifqLVO5HNc3gXQCDM2M99Sbmn1YtbrgsU9xMYfcPmvQvb+YoKskyoqck+c
HR//hi7vslbxABrny15LBkEfRc4TickphSGYXwIDAQABAoIBAATEzGw8/WwMIQRx
K06GeWgh7PZBHm4+m/ud2TtSXiJ0CE+7dXs3cJJIiOd/LW08/bhE6gCkjmYHfaRB
Ryicv1X/cPmzIFX5BuQ4a5ZGOmrVDkKBE27vSxAgJoR46RvWnjx9XLMp/xaekDxz
psldK8X4DvV1ZbltgDFWji947hvyqUtHdKnkQnc5j7aCIFJf9GMfzaeeDPMaL8WF
mVL4iy9EAOjNOHBshZj/OHyU5FbJ8ROwZQlCOiLCdFegftSIXt8EYDnjB3BdsALH
N6hquqrD7xDKyRbTD0K7lqxUubuMwTQpi61jZD8TBTXEPyFVAnoMpXkc0Y+np40A
YiIsR+kCgYEAyrc4Bh6fb9gt49IXGXOSRZ5i5+TmJho4kzIONrJ7Ndclwx9wzHfh
eGBodWaw5CxxQGMf4vEiaZrpAiSFeDffBLR+Wa2TFE5aWkdYkR34maDjO00m4PE1
S+YsZoGw7rGmmj+KS4qv2T26FEHtUI+F31RC1FPohLsQ22Jbn1ORipsCgYEAyrYB
J2Ncf2DlX1C0GfxyUHQOTNl0V5gpGvpbZ0WmWksumYz2kSGOAJkxuDKd9mKVlAcz
czmN+OOetuHTNqds2JJKKJy6hJbgCdd9aho3dId5Xs4oh4YwuFQiG8R/bJZfTlXo
99Qr02L7MmDWYLmrR3BA/93UPeorHPtjqSaYU40CgYEAtmGfWwokIglaSDVVqQVs
3YwBqmcrla5TpkMLvLRZ2/fktqfL4Xod9iKu+Klajv9ZKTfFkXWno2HHL7FSD/Yc
hWwqnV5oDIXuDnlQOse/SeERb+IbD5iUfePpoJQgbrCQlwiB0TNGwOojR2SFMczf
Ai4aLlQLx5dSND9K9Y7HS+8CgYEAixlHQ2r4LuQjoTs0ytwi6TgqE+vn3K+qDTwc
eoods7oBWRaUn1RCKAD3UClToZ1WfMRQNtIYrOAsqdveXpOWqioAP0wE5TTOuZIo
GiWxRgIsc7TNtOmNBv+chCdbNP0emxdyjJUIGb7DFnfCw47EjHnn8Guc13uXaATN
B2ZXgoUCgYAGa13P0ggUf5BMJpBd8S08jKRyvZb1CDXcUCuGtk2yEx45ern9U5WY
zJ13E5z9MKKO8nkGBqrRfjJa8Xhxk4HKNFuzHEet5lvNE7IKCF4YQRb0ZBhnb/78
+4ZKjFki1RrWRNSw9TdvrK6qaDKgTtCTtfRVXAYQXUgq7lSFOTtL3A==
-----END RSA PRIVATE KEY-----
DOC
  end
  # rubocop:enable Layout/IndentHeredoc

  let :params do {
    :cert_content => valid_cert,
    :key_content  => valid_key,
  } end

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
#              :cert_content => valid_cert,
#              :key_content  => valid_key,
              :service      => :undef,
            }
          }

          it { is_expected.to contain_file('/etc/ssl/certs').with_ensure('directory') }
          it { is_expected.to contain_file('/etc/ssl/private').with_ensure('directory') }
          it { is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').with_group('root') }
          it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_group('root') }
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
              :cert_content => valid_cert,
              :key_content  => valid_key,
#              :cert_content => $cert,
#              :key_content  => $key,
              :service      => :undef,
            }
          }

          it { is_expected.to contain_file('/usr/local/etc/apache24').with_ensure('directory') }
          it { is_expected.to contain_file('/usr/local/etc/apache24').with_group('wheel') }
          it { is_expected.to contain_file('/usr/local/etc/apache24/base.example.org.crt').with_group('wheel') }
          it { is_expected.to contain_file('/usr/local/etc/apache24/base.example.org.key').with_group('wheel') }
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
              :cert_content => valid_cert,
              :key_content  => valid_key,
#              :cert_content => $cert,
#              :key_content  => $key,
              :service      => :undef,
            }
          }

          it { is_expected.to contain_file('/etc/ssl/apache2').with_ensure('directory') }
          it { is_expected.to contain_file('/etc/ssl/apache2').with_group('wheel') }
          it { is_expected.to contain_file('/etc/ssl/apache2/base.example.org.crt').with_group('wheel') }
          it { is_expected.to contain_file('/etc/ssl/apache2/base.example.org.key').with_group('wheel') }
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
              :cert_content => valid_cert,
              :key_content  => valid_key,
#              :cert_content => $cert,
#              :key_content  => $key,
              :service      => :undef,
            }
          }

          it { is_expected.to contain_file('/etc/pki/tls/certs').with_ensure('directory') }
          it { is_expected.to contain_file('/etc/pki/tls/private').with_ensure('directory') }
          it { is_expected.to contain_file('/etc/pki/tls/certs/base.example.org.crt').with_group('root') }
          it { is_expected.to contain_file('/etc/pki/tls/private/base.example.org.key').with_group('root') }
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
          :cert_content => valid_cert,
          :key_content  => valid_key,
          :service      => :undef,
        }
      }

      it { is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').with_content(/^-----BEGIN*/) }
      it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_content(/^-----BEGIN*/) }
    end

    context 'with ensure => absent' do
      let(:params) {
        {
          :cert_content => valid_cert,
          :key_content  => valid_key,
          :service      => :undef,
          :ensure       => 'absent'
        }
      }

      it { is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').with_ensure('absent') }
      it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_ensure('absent') }
    end

    context 'with CA cert' do
      let(:params) {
        {
          :cert_content => valid_cert,
          :key_content  => valid_key,
          :service      => :undef,
          :ca_cert      => true,
          :ca_name      => 'ca',
          :ca_content   => 'ca2222',
          :ensure       => 'present'
        }
      }

      it { is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').with_content(/^-----BEGIN*/) }
      it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_content(/^-----BEGIN*/) }
      it { is_expected.to contain_file('/etc/ssl/certs/ca.crt').with_content(/ca2222/) }
    end

    context 'with chain cert' do
      let(:params) {
        {
          :cert_content => valid_cert,
          :key_content  => valid_key,
          :service      => :undef,
          :ca_cert      => true,
          :ca_name      => 'chain',
          :ca_content   => 'chain3333',
          :ensure       => 'present'
        }
      }

      it { is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').with_content(/^-----BEGIN*/) }
      it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_content(/^-----BEGIN*/) }
      it { is_expected.to contain_file('/etc/ssl/certs/chain.crt').with_content(/chain3333/) }
    end

    context 'with merge_chain set to true with CA' do
      let(:params) {
        {
          :cert_content => valid_cert,
          :key_content  => valid_key,
          :service      => :undef,
          :ensure       => 'present',
          :ca_cert      => true,
          :ca_name      => 'ca',
          :ca_content   => 'ca2222',
          :merge_chain  => true
        }
      }

      it { is_expected.to contain_concat('base.example.org_cert_merged') }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_certificate').with(
          :content => /^-----BEGIN*/ )
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_ca').with(
          :content => /ca2222/ )
      }
      it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_content(/^-----BEGIN*/) }
      it { is_expected.to contain_file('/etc/ssl/certs/ca.crt').with_content(/ca2222/) }
    end

    context 'with merge_chain set to true with chain' do
      let(:params) {
        {
          :cert_content  => valid_cert,
          :key_content   => valid_key,
          :service       => :undef,
          :ensure        => 'present',
          :cert_chain    => true,
          :chain_name    => 'chain',
          :chain_content => 'chain3333',
          :merge_chain   => true
        }
      }

      it { is_expected.to contain_concat('base.example.org_cert_merged') }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_certificate').with(
          :content => /^-----BEGIN*/ )
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_chain').with(
          :content => /chain3333/ )
      }
      it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_content(/^-----BEGIN*/) }
      it { is_expected.to contain_file('/etc/ssl/certs/chain.crt').with_content(/chain3333/) }
    end

    context 'with merge_chain set to true with CA and chain' do
      let(:params) {
        {
          :cert_content  => valid_cert,
          :key_content   => valid_key,
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

      it { is_expected.to contain_concat('base.example.org_cert_merged') }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_certificate').with(
          :content => /^-----BEGIN*/ )
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_ca').with(
          :content => /ca2222/ )
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_chain').with(
          :content => /chain3333/ )
      }
      it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_content(/^-----BEGIN*/) }
      it { is_expected.to contain_file('/etc/ssl/certs/ca.crt').with_content(/ca2222/) }
      it { is_expected.to contain_file('/etc/ssl/certs/chain.crt').with_content(/chain3333/) }
    end

    context 'with merge_chain set to false and merge_key set to true with neither chain nor CA' do
      let(:params) {
        {
          :cert_content  => valid_cert,
          :key_content   => valid_key,
          :service       => :undef,
          :ensure        => 'present',
          :merge_chain   => false,
          :merge_key     => true
        }
      }

      it { is_expected.to contain_concat('base.example.org_cert_merged') }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_certificate').with(
          :content => /^-----BEGIN*/ )
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_key').with(
          :content => /^-----BEGIN*/ )
      }
      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_ca')
      }
      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_chain')
      }
      it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_content(/^-----BEGIN*/) }
    end

    context 'with merge_chain set to false and merge_key set to true with chain and CA set' do
      let(:params) {
        {
          :cert_content  => valid_cert,
          :key_content   => valid_key,
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
        }
      }

      it { is_expected.to contain_concat('base.example.org_cert_merged') }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_certificate').with(
          :content => /^-----BEGIN*/ )
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_key').with(
          :content => /^-----BEGIN*/ )
      }
      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_ca')
      }
      it {
        is_expected.not_to contain_concat__fragment('base.example.org.crt_chain')
      }
      it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_content(/^-----BEGIN*/) }
      it { is_expected.to contain_file('/etc/ssl/certs/ca.crt').with_content(/ca2222/) }
      it { is_expected.to contain_file('/etc/ssl/certs/chain.crt').with_content(/chain3333/) }
    end

    context 'with merge_chain and merge_key set to true with chain' do
      let(:params) {
        {
          :cert_content  => valid_cert,
          :key_content   => valid_key,
          :service       => :undef,
          :ensure        => 'present',
          :cert_chain    => true,
          :chain_name    => 'chain',
          :chain_content => 'chain3333',
          :merge_chain   => true,
          :merge_key     => true
        }
      }

      it { is_expected.to contain_concat('base.example.org_cert_merged') }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_certificate').with(
          :content => /^-----BEGIN*/ )
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_key').with(
          :content => /^-----BEGIN*/ )
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_chain').with(
          :content => /chain3333/ )
      }
      it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_content(/^-----BEGIN*/) }
      it { is_expected.to contain_file('/etc/ssl/certs/chain.crt').with_content(/chain3333/) }
    end

    context 'with merge_chain and merge_key set to true with CA and chain' do
      let(:params) {
        {
          :cert_content  => valid_cert,
          :key_content   => valid_key,
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
        }
      }

      it { is_expected.to contain_concat('base.example.org_cert_merged') }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_certificate').with(
          :content => /^-----BEGIN*/ )
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_key').with(
          :content => /^-----BEGIN*/ )
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_ca').with(
          :content => /ca2222/ )
      }
      it {
        is_expected.to contain_concat__fragment('base.example.org.crt_chain').with(
          :content => /chain3333/ )
      }
      it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_content(/^-----BEGIN*/) }
      it { is_expected.to contain_file('/etc/ssl/certs/ca.crt').with_content(/ca2222/) }
      it { is_expected.to contain_file('/etc/ssl/certs/chain.crt').with_content(/chain3333/) }
    end

    context 'with a custom user set' do
      let(:params) {
        {
          :cert_content  => valid_cert,
          :key_content   => valid_key,
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

      it { is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').with_owner('newowner') }
      it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_owner('newowner') }
      it { is_expected.to contain_file('/etc/ssl/certs/ca.crt').with_owner('newowner') }
      it { is_expected.to contain_file('/etc/ssl/certs/chain.crt').with_owner('newowner') }
    end

    context 'with a custom group set' do
      let(:params) {
        {
          :cert_content  => valid_cert,
          :key_content   => valid_key,
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

      it { is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').with_group('newgroup') }
      it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_group('newgroup') }
      it { is_expected.to contain_file('/etc/ssl/certs/ca.crt').with_group('newgroup') }
      it { is_expected.to contain_file('/etc/ssl/certs/chain.crt').with_group('newgroup') }
    end

    context 'with a custom file and directory modes set' do
      let(:params) {
        {
          :cert_content  => valid_cert,
          :key_content   => valid_key,
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

      it { is_expected.to contain_file('/etc/ssl/certs').with_ensure('directory') }
      it { is_expected.to contain_file('/etc/ssl/certs').with_mode('0500') }
      it { is_expected.to contain_file('/etc/ssl/private').with_ensure('directory') }
      it { is_expected.to contain_file('/etc/ssl/private').with_mode('0500') }

      it { is_expected.to contain_file('/etc/ssl/certs/base.example.org.crt').with_mode('0700') }
      it { is_expected.to contain_file('/etc/ssl/private/base.example.org.key').with_mode('0400') }
      it { is_expected.to contain_file('/etc/ssl/certs/ca.crt').with_mode('0700') }
      it { is_expected.to contain_file('/etc/ssl/certs/chain.crt').with_mode('0700') }
    end

    context 'with custom extensions set' do
      let :params do {
          :cert_content  => valid_cert,
          :key_content   => valid_key,
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
      } end

      it { is_expected.to contain_file('/etc/ssl/certs/base.example.org.pem') }
      it { is_expected.to contain_file('/etc/ssl/private/base.example.org.pem') }
      it { is_expected.to contain_file('/etc/ssl/certs/ca.pem') }
      it { is_expected.to contain_file('/etc/ssl/certs/chain.pem') }
    end
  end
end
