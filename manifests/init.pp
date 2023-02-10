#
# @summary The certificates class provides a single define, `certificates::site`, configurable within Hiera as well.
#
# @example Set some basic global options
#  class { 'certificates':
#    cert_path => '/path/to/certs',
#    key_path  => '/path/to/keys',
#  }
#
# @param ca_cert
#   Boolean for whether to look for a CA certificate file.
#   Optional value. (default: false).
#
# @param ca_content
#   A string representing the contents of the CA file.
#   Optional value. (default: undef).
#
# @param ca_ext
#   The extension of the CA certificate file.
#   This sets the default globally for use by all `certificates::site` resources.
#   Optional value. (default: 'crt').
#
# @param ca_name
#   The name of the CA certificate file.
#   Optional value. (default: undef).
#
# @param ca_path
#   Location where the CA certificate file will be stored on the managed node.
#   This sets the default globally for use by all `certificates::site` resources.
#   Optional value. (default: `cert_path`).
#
# @param ca_source_path
#   The location of the CA certificate file. Typically references a module's files.
#   e.g. `puppet:///ca_certs` will search for the mount point defined in the
#   fileserver.conf on the Puppet Server for the specified files.
#   Optional value. (default: `source_path`).
#
# @param cert_chain
#   Boolean for whether to look for a certificate chain file.
#   Optional value. (default: false).
#
# @param cert_content
#   A string representing the contents of the certificate file.  This can only be
#   provided if `$source_path` is undefined or an error will occur.
#   Optional value. (default: undef).
#
# @param cert_dir_mode
#   Permissions of the certificate directory.
#   This sets the default globally for use by all `certificates::site` resources.
#   Optional value. (default: '0755').
#
# @param cert_ext
#   The extension of the certificate file.
#   This sets the default globally for use by all `certificates::site` resources.
#   Optional value. (default: '.crt').
#
# @param cert_mode
#   Permissions of the certificate files.
#   This sets the default globally for use by all `certificates::site` resources.
#   Optional value. (default: '0644').
#
# @param cert_path
#   Location where the certificate files will be stored on the managed node.
#   This sets the default globally for use by all `certificates::site` resources.
#   Optional value. Defaults:
#     - `/etc/pki/tls/certs` on RedHat-based systems
#     - `/etc/ssl/certs` on Debian-based and Suse-based systems
#     - `/usr/local/etc/apache24` on FreeBSD-based systems
#     - `/etc/ssl/apache2` on Gentoo-based systems
#
# @param chain_content
#   A string representing the contents of the chain file.
#   Optional value. (default: undef).
#
# @param chain_ext
#   The extension of the certificate chain file.
#   This sets the default globally for use by all `certificates::site` resources.
#   Optional value. (default: 'crt').
#
# @param chain_name
#   The name of the certificate chain file.
#   Optional value. (default: undef).
#
# @param chain_path
#   Location where the certificate chain file will be stored on the managed node.
#   This sets the default globally for use by all `certificates::site` resources.
#   Optional value. (default: `$cert_path`).
#
# @param chain_source_path
#   The location of the certificate chain file. Typically references a module's files.
#   e.g. `puppet:///chain_certs` will search for the mount point defined in the
#   fileserver.conf on the Puppet Server for the specified files.
#   Optional value. (default: `$source_path`).
#
# @param dhparam_file
#   The name of the dhparam file.
#   This sets the default globally for use by all `certificates::site` resources.
#   Optional value. (default: 'dh2048.pem').
#
# @param group
#   Name of the group owner of the certificates.
#   This sets the default globally for use by all `certificates::site` resources.
#   Optional value. Defaults:
#     - `root` for Redhat-based, Debian-based, and Suse-based systems
#     - `wheel` for FreeBSD and Gentoo-based systems
#
# @param key_content
#   A string representing the contents of the key file.  This can only be
#   provided if `$source_path` is undefined or an error will occur.
#   Optional value. (default: undef).
#
# @param key_dir_mode
#   Permissions of the private keys directory.
#   This sets the default globally for use by all `certificates::site` resources.
#   Optional value. (default: '0755').
#
# @param key_ext
#   The extension of the private key file.
#   This sets the default globally for use by all `certificates::site` resources.
#   Optional value. (default: '.key').
#
# @param key_mode
#   Permissions of the private keys.
#   This sets the default globally for use by all `certificates::site` resources.
#   Optional value. (default: '0600').
#
# @param key_path
#   Location where the private keys will be stored on the managed node.
#   This sets the default globally for use by all `certificates::site` resources.
#   Optional value. Defaults:
#     - `/etc/pki/tls/private` on RedHat-based systems
#     - `/etc/ssl/private` on Debian-based and Suse-based systems
#     - `/usr/local/etc/apache24` on FreeBSD-based systems
#     - `/etc/ssl/apache2` on Gentoo-based systems
#
# @param owner
#   Name of the owner of the certificates.
#   This sets the default globally for use by all `certificates::site` resources.
#   Optional value. (default: 'root').
#
# @param service
#   Name of the server service(s) to notify when certificates are updated.
#   Setting to false (or any Boolean) will disable service notifications.
#   This sets the default globally for use by all `certificates::site` resources.
#   Optional value. Defaults:
#     - `httpd` for RedHat-based systems
#     - `apache2` for Debian-based, Suse-based, and Gentoo-based systems
#     - `apache24` for FreeBSD-based systems
#
# @param sites
#   A hash of `certificates::site` configurations, typically provided by Hiera.
#   Optional value: (default: {}).
#
# @param source_path
#   The location of the certificate files. Typically references a module's files.
#   e.g. `puppet:///site_certs` will search for the mount point defined in the
#   fileserver.conf on the Puppet Server for the specified files.
#
# @param supported_os
#   A boolean value for whether or not the running OS is supported by the module.
#   Configured by default data.
#
# @param validate_x509
#   A boolean value to determine whether or not to validate the certificate and key pairs.
#   Failure will cause the catalog to fail compilation.
#   Optional value. (default: false).
#
class certificates (
  String $cert_dir_mode,
  String $cert_ext,
  String $cert_mode,
  Stdlib::Absolutepath $cert_path,
  String $dhparam_file,
  String $group,
  String $key_dir_mode,
  String $key_ext,
  String $key_mode,
  Stdlib::Absolutepath $key_path,
  String $owner,
  Boolean $ca_cert                                         = false,
  Optional[String] $ca_content                             = undef,
  String $ca_ext                                           = lookup('certificates::cert_ext'),
  Optional[String] $ca_name                                = undef,
  Stdlib::Absolutepath $ca_path                            = lookup('certificates::cert_path'),
  Boolean $cert_chain                                      = false,
  Optional[String] $cert_content                           = undef,
  Optional[String] $chain_content                          = undef,
  String $chain_ext                                        = lookup('certificates::cert_ext'),
  Optional[String] $chain_name                             = undef,
  Stdlib::Absolutepath $chain_path                         = lookup('certificates::cert_path'),
  Optional[String] $key_content                            = undef,
  Optional[Variant[Array[String],Boolean,String]] $service = lookup('certificates::service'),
  Hash $sites                                              = {},
  Optional[String] $source_path                            = undef,
  Boolean $supported_os                                    = false,
  Boolean $validate_x509                                   = false,
  Optional[String] $ca_source_path                         = $source_path,
  Optional[String] $chain_source_path                      = $source_path,
) {
  unless $supported_os {
    fail("Class['certificates']: Unsupported osfamily: ${facts['osfamily']}")
  }

  create_resources('certificates::site', $sites)

  # For nodes that have EL6/EL7-style ca trust mechanism
  exec { 'update_ca_trust':
    path        => '/usr/bin:/bin',
    command     => '/usr/bin/update-ca-trust extract',
    refreshonly => true,
  }
}
