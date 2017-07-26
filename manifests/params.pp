#
# === Default Parameters
#
class certs::params {
    case $::osfamily {
        'RedHat': {
            $cert_path = '/etc/pki/tls/certs'
            $key_path  = '/etc/pki/tls/private'
            $service   = 'httpd'
            $group     = 'root'
        }
        'Debian', 'Suse': {
            $cert_path = '/etc/ssl/certs'
            $key_path  = '/etc/ssl/private'
            $service   = 'apache2'
            $group     = 'root'
        }
        'FreeBSD': {
            $cert_path = '/usr/local/etc/apache24'
            $key_path  = '/usr/local/etc/apache24'
            $service   = 'apache24'
            $group     = 'wheel'
        }
        'Gentoo': {
            $cert_path = '/etc/ssl/apache2'
            $key_path  = '/etc/ssl/apache2'
            $service   = 'apache2'
            $group     = 'wheel'
        }
        default: {
            fail("Class['certs::params']: Unsupported osfamily: ${::osfamily}")
        }
    }
    $ca_name       = undef
    $cert_dir_mode = '0755'
    $cert_ext      = '.crt'
    $cert_mode     = '0644'
    $chain_name    = undef
    $dhparam_file  = 'dh2048.pem'
    $key_dir_mode  = '0755'
    $key_ext       = '.key'
    $key_mode      = '0600'
    $owner         = 'root'

    $ca_ext        = $cert_ext
    $ca_path       = $cert_path
    $chain_ext     = $cert_ext
    $chain_path    = $cert_path
}
