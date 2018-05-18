# == Class: certs
#
# The certs class provides a single define, certs::site, configurable
# within Hiera as well.
#
# === Authors
#
# Riccardo Calixte <rcalixte@broadinstitute.org>
# Andrew Teixeira <teixeira@broadinstitute.org>
#
# === Parameters
#
# [*ca_ext*]
# The extension of the CA certificate file.
# This sets the default globally for use by all certs::site resources.
# Optional value. Default: crt.
#
# [*ca_path*]
# Location where the CA certificate file will be stored on the managed node.
# This sets the default globally for use by all certs::site resources.
# Optional value. Default: [*cert_path*].
#
# [*cert_dir_mode*]
# Permissions of the certificate directory.
# This sets the default globally for use by all certs::site resources.
# Optional value. Default: '0755'.
#
# [*cert_ext*]
# The extension of the certificate file.
# This sets the default globally for use by all certs::site resources.
# Optional value. Default: '.crt'.
#
# [*cert_mode*]
# Permissions of the certificate files.
# This sets the default globally for use by all certs::site resources.
# Optional value. Default: '0644'.
#
# [*cert_path*]
# Location where the certificate files will be stored on the managed node.
# This sets the default globally for use by all certs::site resources.
# Optional value. Defaults:
#   - '/etc/pki/tls/certs' on RedHat-based systems
#   - '/etc/ssl/certs' on Debian-based and Suse-based systems
#   - '/usr/local/etc/apache24' on FreeBSD-based systems
#   - '/etc/ssl/apache2' on Gentoo-based systems
#
# [*chain_ext*]
# The extension of the certificate chain file.
# This sets the default globally for use by all certs::site resources.
# Optional value. Default: crt.
#
# [*chain_path*]
# Location where the certificate chain file will be stored on the managed node.
# This sets the default globally for use by all certs::site resources.
# Optional value. Default: [*cert_path*].
#
# [*dhparam_file*]
# The name of the dhparam file.
# This sets the default globally for use by all certs::site resources.
# Optional value. Default: 'dh2048.pem'.
#
# [*group*]
# Name of the group owner of the certificates.
# This sets the default globally for use by all certs::site resources.
# Optional value. Defaults:
#   - 'root' for Redhat-based, Debian-based, and Suse-based systems
#   - 'wheel' for FreeBSD and Gentoo-based systems
#
# [*key_dir_mode*]
# Permissions of the private keys directory.
# This sets the default globally for use by all certs::site resources.
# Optional value. Default: '0755'.
#
# [*key_ext*]
# The extension of the private key file.
# This sets the default globally for use by all certs::site resources.
# Optional value. Default: '.key'.
#
# [*key_mode*]
# Permissions of the private keys.
# This sets the default globally for use by all certs::site resources.
# Optional value. Default: '0600'.
#
# [*key_path*]
# Location where the private keys will be stored on the managed node.
# This sets the default globally for use by all certs::site resources.
# Optional value. Defaults:
#   - '/etc/pki/tls/private' on RedHat-based systems
#   - '/etc/ssl/private' on Debian-based and Suse-based systems
#   - '/usr/local/etc/apache24' on FreeBSD-based systems
#   - '/etc/ssl/apache2' on Gentoo-based systems
#
# [*owner*]
# Name of the owner of the certificates.
# This sets the default globally for use by all certs::site resources.
# Optional value. Default: 'root'.
#
# [*service*]
# Name of the server service to notify when certificates are updated.
# Setting to `undef` will disable service notifications.
# This sets the default globally for use by all certs::site resources.
# Optional value. Defaults:
#   - 'httpd' for RedHat-based systems
#   - 'apache2' for Debian-based, Suse-based, and Gentoo-based systems
#   - 'apache24' for FreeBSD-based systems
#
# [*sites*]
# A hash of certs::site configurations, typically provided by Hiera.
# Optional value: Default: {}
#
# [*supported_os*]
# A boolean value for whether or not the running OS is supported by the module.
# Configured by default data.
#
# [*validate_x509*]
# A boolean value to determine whether or not to validate the certificate and key pairs.
# Failure will cause the catalog to fail compilation.
# Optional value. Default: false.
#
class certs(
  Stdlib::Absolutepath $cert_path,
  Stdlib::Absolutepath $key_path,
  String $cert_dir_mode,
  String $cert_ext,
  String $cert_mode,
  String $dhparam_file,
  String $group,
  String $key_dir_mode,
  String $key_ext,
  String $key_mode,
  String $owner,
  Optional[String] $service,
  String $ca_ext                   = lookup('certs::cert_ext'),
  Stdlib::Absolutepath $ca_path    = lookup('certs::cert_path'),
  String $chain_ext                = lookup('certs::cert_ext'),
  Stdlib::Absolutepath $chain_path = lookup('certs::cert_path'),
  Boolean $supported_os            = false,
  Boolean $validate_x509           = false,
  Hash $sites                      = {}
) {
  unless $supported_os {
    fail("Class['certs']: Unsupported osfamily: ${facts['osfamily']}")
  }

  create_resources('certs::site', $sites)

  # For nodes that have EL6/EL7-style ca trust mechanism
  exec { 'update_ca_trust':
    path        => '/usr/bin:/bin',
    command     => '/usr/bin/update-ca-trust extract',
    refreshonly => true,
  }
}
