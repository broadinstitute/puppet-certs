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
# === Copyright
#
# Copyright 2016
#
# === Parameters
#
# [ca_ext]
# The extension of the CA certificate file.
# This sets the default globally for use by all certs::site resources.
# Optional value. Default: crt.
#
# [ca_path]
# Location where the CA certificate file will be stored on the managed node.
# This sets the default globally for use by all certs::site resources.
# Optional value. Default: [cert_path].
#
# [cert_dir_mode]
# Permissions of the certificate directory.
# This sets the default globally for use by all certs::site resources.
# Optional value. Default: '0755'.
#
# [cert_ext]
# The extension of the certificate file.
# This sets the default globally for use by all certs::site resources.
# Optional value. Default: '.crt'.
#
# [cert_mode]
# Permissions of the certificate files.
# This sets the default globally for use by all certs::site resources.
# Optional value. Default: '0644'.
#
# [cert_path]
# Location where the certificate files will be stored on the managed node.
# This sets the default globally for use by all certs::site resources.
# Optional value. Defaults:
#   - '/etc/pki/tls/certs' on RedHat-based systems
#   - '/etc/ssl/certs' on Debian-based and Suse-based systems
#   - '/usr/local/etc/apache24' on FreeBSD-based systems
#   - '/etc/ssl/apache2' on Gentoo-based systems
#
# [chain_ext]
# The extension of the certificate chain file.
# This sets the default globally for use by all certs::site resources.
# Optional value. Default: crt.
#
# [chain_path]
# Location where the certificate chain file will be stored on the managed node.
# This sets the default globally for use by all certs::site resources.
# Optional value. Default: [cert_path].
#
# [dhparam_file]
# The name of the dhparam file.
# This sets the default globally for use by all certs::site resources.
# Optional value. Default: 'dh2048.pem'.
#
# [group]
# Name of the group owner of the certificates.
# This sets the default globally for use by all certs::site resources.
# Optional value. Defaults:
#   - 'root' for Redhat-based, Debian-based, and Suse-based systems
#   - 'wheel' for FreeBSD and Gentoo-based systems
#
# [key_dir_mode]
# Permissions of the private keys directory.
# This sets the default globally for use by all certs::site resources.
# Optional value. Default: '0755'.
#
# [key_ext]
# The extension of the private key file.
# This sets the default globally for use by all certs::site resources.
# Optional value. Default: '.key'.
#
# [key_mode]
# Permissions of the private keys.
# This sets the default globally for use by all certs::site resources.
# Optional value. Default: '0600'.
#
# [key_path]
# Location where the private keys will be stored on the managed node.
# This sets the default globally for use by all certs::site resources.
# Optional value. Defaults:
#   - '/etc/pki/tls/private' on RedHat-based systems
#   - '/etc/ssl/private' on Debian-based and Suse-based systems
#   - '/usr/local/etc/apache24' on FreeBSD-based systems
#   - '/etc/ssl/apache2' on Gentoo-based systems
#
# [owner]
# Name of the owner of the certificates.
# This sets the default globally for use by all certs::site resources.
# Optional value. Default: 'root'.
#
# [service]
# Name of the server service to notify when certificates are updated.
# Setting to `undef` will disable service notifications.
# This sets the default globally for use by all certs::site resources.
# Optional value. Defaults:
#   - 'httpd' for RedHat-based systems
#   - 'apache2' for Debian-based, Suse-based, and Gentoo-based systems
#   - 'apache24' for FreeBSD-based systems
#
# [sites]
# A hash of certs::site configurations, typically provided by Hiera.
# Optional value: Default: {}
#
class certs (
    $ca_ext        = undef,
    $ca_path       = undef,
    $cert_dir_mode = undef,
    $cert_ext      = undef,
    $cert_mode     = undef,
    $cert_path     = undef,
    $chain_ext     = undef,
    $chain_path    = undef,
    $dhparam_file  = undef,
    $group         = undef,
    $key_dir_mode  = undef,
    $key_ext       = undef,
    $key_mode      = undef,
    $key_path      = undef,
    $owner         = undef,
    $service       = undef,
    $sites         = hiera_hash('certs::sites', {}),
) {

    include ::certs::params

    $_ca_ext        = pick_default($ca_ext, $::certs::params::ca_ext)
    $_ca_path       = pick_default($ca_path, $::certs::params::ca_path)
    $_cert_dir_mode = pick_default($cert_dir_mode, $::certs::params::cert_dir_mode)
    $_cert_ext      = pick_default($cert_ext, $::certs::params::cert_ext)
    $_cert_mode     = pick_default($cert_mode, $::certs::params::cert_mode)
    $_cert_path     = pick_default($cert_path, $::certs::params::cert_path)
    $_chain_ext     = pick_default($chain_ext, $::certs::params::chain_ext)
    $_chain_path    = pick_default($chain_path, $::certs::params::chain_path)
    $_dhparam_file  = pick_default($dhparam_file, $::certs::params::dhparam_file)
    $_group         = pick_default($group, $::certs::params::group)
    $_key_dir_mode  = pick_default($key_dir_mode, $::certs::params::key_dir_mode)
    $_key_ext       = pick_default($key_ext, $::certs::params::key_ext)
    $_key_mode      = pick_default($key_mode, $::certs::params::key_mode)
    $_key_path      = pick_default($key_path, $::certs::params::key_path)
    $_owner         = pick_default($owner, $::certs::params::owner)
    $_service       = pick_default($service, $::certs::params::service)

    validate_string($_ca_ext)
    validate_absolute_path($_ca_path)
    validate_string($_cert_dir_mode)
    validate_numeric($_cert_dir_mode)
    validate_string($_cert_ext)
    validate_string($_cert_mode)
    validate_numeric($_cert_mode)
    validate_absolute_path($_cert_path)
    validate_string($_chain_ext)
    validate_absolute_path($_chain_path)
    validate_string($_group)
    validate_string($_key_dir_mode)
    validate_numeric($_key_dir_mode)
    validate_string($_key_ext)
    validate_string($_key_mode)
    validate_numeric($_key_mode)
    validate_absolute_path($_key_path)
    validate_string($_owner)

    if $service != undef {
        validate_string($service)
    }

    create_resources('certs::site', $sites)
}
