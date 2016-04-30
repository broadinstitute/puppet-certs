#
# === Parameters
#
# [name]
# The title of the resource matches the certificate's name
# e.g. 'www.example.com' matches the certificate for the hostname
# 'www.example.com'
#
# [source_path]
# The location of the certificate files. Typically references a module's files.
# e.g. 'puppet:///site_certs' will search $fileserverconfpath on the master for
# the specified files.
#
# [cert_ext]
# The extension of the certificate file.
# Optional value. Defaults to crt.
#
# [cert_path]
# Location where the certificate files will be stored on the managed node.
# Optional value. Defaults:
#   - '/etc/pki/tls/certs' on RedHat-based systems
#   - '/etc/ssl/certs' on Debian-based and Suse-based systems
#   - '/usr/local/etc/apache24' on FreeBSD-based systems
#   - '/etc/ssl/apache2' on Gentoo-based systems
#
# [keys_path]
# Location where the private keys will be stored on the managed node.
# Optional value. Defaults:
#   - '/etc/pki/tls/private' on RedHat-based systems
#   - '/etc/ssl/private' on Debian-based and Suse-based systems
#   - '/usr/local/etc/apache24' on FreeBSD-based systems
#   - '/etc/ssl/apache2' on Gentoo-based systems
#
# [cert_chain]
# Boolean for whether to look for a certificate chain file.
# Optional value. Defaults to false.
#
# [chain_name]
# The name of the certificate chain file.
# Optional value. Defaults to undef.
#
# [chain_ext]
# The extension of the certificate chain file.
# Optional value. Defaults to crt.
#
# [chain_path]
# Location where the certificate chain file will be stored on the managed node.
# Defaults to the cert_path.
#
# [chain_source_path]
# The location of the certificate chain file. Typically references a module's files.
# e.g. 'puppet:///chain_certs' will search $fileserverconfpath on the master for the
# specified files. Defaults to source_path.
# 
# [ca_cert]
# Boolean for whether to look for a CA certificate file.
# Optional value. Defaults to false.
# 
# [ca_name]
# The name of the CA certificate file.
# Optional value. Defaults to undef.
#
# [ca_ext]
# The extension of the CA certificate file.
# Optional value. Defaults to crt.
#
# [ca_path]
# Location where the CA certificate file will be stored on the managed node.
# Optional value. Defaults to the cert_path.
#
# [ca_source_path]
# The location of the CA certificate file. Typically references a module's files.
# e.g. 'puppet:///ca_certs' will search $fileserverconfpath on the master for the
# specified files. Defaults to source_path.
#
# [service]
# Name of the web server service to notify when certificates are updated.
# Optional value. Defaults:
#   - 'httpd' for RedHat-based systems
#   - 'apache2' for Debian-based, Suse-based, and Gentoo-based systems
#   - 'apache24' for FreeBSD-based systems
#
# [owner]
# Name of the owner of the certificates.
# Optional value. Defaults to 'root' for all systems
#
# [group]
# Name of the group owner of the certificates.
# Optional value. Defaults:
#   - 'root' for Redhat-based, Debian-based, and Suse-based systems
#   - 'wheel' for FreeBSD and Gentoo-based systems
#
# [cert_mode]
# Permissions of the certificate files.
# Optional value. Defaults to 0644 for all systems.
#
# [key_mode]
# Permissions of the private keys.
# Optional value. Defaults to 0600 for all systems.
#
class certs::params {
  case $::osfamily {
    'RedHat': {
      $cert_path  = '/etc/pki/tls/certs'
      $keys_path  = '/etc/pki/tls/private'
      $service    = 'httpd'
      $group      = 'root'
    }
    'Debian', 'Suse': {
      $cert_path  = '/etc/ssl/certs'
      $keys_path  = '/etc/ssl/private'
      $service    = 'apache2'
      $group      = 'root'
    }
    'FreeBSD': {
      $cert_path  = '/usr/local/etc/apache24'
      $keys_path  = '/usr/local/etc/apache24'
      $service    = 'apache24'
      $group      = 'wheel'
    }
    'Gentoo': {
      $cert_path  = '/etc/ssl/apache2'
      $keys_path  = '/etc/ssl/apache2'
      $service    = 'apache2'
      $group      = 'wheel'
    }
    default: {
      fail("Class['certs::params']: Unsupported osfamily: ${::osfamily}")
    }
  }
  $cert_ext   = '.crt'
  $cert_chain = false
  $chain_name = ''
  $chain_ext  = $cert_ext
  $chain_path = $cert_path
  $ca_cert    = false
  $ca_name    = ''
  $ca_ext     = $cert_ext
  $ca_path    = $cert_path
  $owner      = 'root'
  $cert_mode  = 0644
  $key_mode   = 0600
}
