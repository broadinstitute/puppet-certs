# == Define: certs::site
#
# Puppet module for SSL certificate installation
#
# Can be used in conjunction with puppetlabs/apache's apache::vhost
# definitions, to provide the ssl_cert and ssl_key files, or any
# other service requiring SSL certificates. It can also be used
# independent of any Puppet-defined service.
#
# === Parameters
#
# [*ca_cert*]
# Boolean for whether to look for a CA certificate file.
# Optional value. Default: false.
#
# [*ca_content*]
# A string representing the contents of the CA file.
# Optional value. Default: undef.
#
# [*ca_ext*]
# The extension of the CA certificate file.
# Optional value. Default: crt.
#
# [*ca_name*]
# The name of the CA certificate file.
# Optional value. Default: undef.
#
# [*ca_path*]
# Location where the CA certificate file will be stored on the managed node.
# Optional value. Default: [*cert_path*].
#
# [*ca_source_path*]
# The location of the CA certificate file. Typically references a module's files.
# e.g. 'puppet:///ca_certs' will search for the mount point defined in the
# fileserver.conf on the Puppet Server for the specified files.
# Optional value. Default: [*source_path*].
#
# [*cert_chain*]
# Boolean for whether to look for a certificate chain file.
# Optional value. Default: false.
#
# [*cert_content*]
# A string representing the contents of the certificate file.  This can only be
# provided if $source_path is undefined or an error will occur.
# Optional value. Default: undef.
#
# [*cert_dir_mode*]
# Permissions of the certificate directory.
# Optional value. Default: '0755'.
#
# [*cert_ext*]
# The extension of the certificate file.
# Optional value. Default: '.crt'.
#
# [*cert_mode*]
# Permissions of the certificate files.
# Optional value. Default: '0644'.
#
# [*cert_path*]
# Location where the certificate files will be stored on the managed node.
# Optional value. Defaults:
#   - '/etc/pki/tls/certs' on RedHat-based systems
#   - '/etc/ssl/certs' on Debian-based and Suse-based systems
#   - '/usr/local/etc/apache24' on FreeBSD-based systems
#   - '/etc/ssl/apache2' on Gentoo-based systems
#
# [*chain_content*]
# A string representing the contents of the chain file.
# Optional value. Default: undef.
#
# [*chain_ext*]
# The extension of the certificate chain file.
# Optional value. Default: crt.
#
# [*chain_name*]
# The name of the certificate chain file.
# Optional value. Default: undef.
#
# [*chain_path*]
# Location where the certificate chain file will be stored on the managed node.
# Optional value. Default: [*cert_path*].
#
# [*chain_source_path*]
# The location of the certificate chain file. Typically references a module's files.
# e.g. 'puppet:///chain_certs' will search for the mount point defined in the
# fileserver.conf on the Puppet Server for the specified files.
# Optional value. Default: [*source_path*].
#
# [*dhparam*]
# A boolean value to determine whether a dhparam file should be placed on the
# system along with the other certificate files.  The dhparam file will need to
# exist on the source side just as with the other certificate files in order
# for the file to be delivered.
# Optional value. Default: false
#
# [*dhparam_content*]
# A string representing the contents of the dhparam file.  This option will
# take precedence over dhparam_file if it exists on the source side.
# Optional value. Default: undef.
#
# [*dhparam_file*]
# The name of the dhparam file.
# Optional value. Default: 'dh2048.pem'.
#
# [*ensure*]
# Ensure for the site resources.  If 'present', files will be put in place.  If
# 'absent', files will be removed.
# Optional value. Default: 'present'
#
# [*group*]
# Name of the group owner of the certificates.
# Optional value. Defaults:
#   - 'root' for Redhat-based, Debian-based, and Suse-based systems
#   - 'wheel' for FreeBSD and Gentoo-based systems
#
# [*key_content*]
# A string representing the contents of the key file.  This can only be
# provided if $source_path is undefined or an error will occur.
# Optional value. Default: undef.
#
# [*key_dir_mode*]
# Permissions of the private keys directory.
# Optional value. Default: '0755'.
#
# [*key_ext*]
# The extension of the private key file.
# Optional value. Default: '.key'.
#
# [*key_mode*]
# Permissions of the private keys.
# Optional value. Default: '0600'.
#
# [*key_path*]
# Location where the private keys will be stored on the managed node.
# Optional value. Defaults:
#   - '/etc/pki/tls/private' on RedHat-based systems
#   - '/etc/ssl/private' on Debian-based and Suse-based systems
#   - '/usr/local/etc/apache24' on FreeBSD-based systems
#   - '/etc/ssl/apache2' on Gentoo-based systems
#
# [*merge_chain*]
# Option to merge the CA and chain files into the actual certificate file,
# which is required by some software.
# Optional value. Default: false.
#
# [*merge_dhparam*]
# Option to merge the DH paramaters file into the actual certificate file,
# which is required by some software.
# Optional value. Default: false.
#
# [*merge_key*]
# Option to merge the private into the actual certificate file, which is
# required by some software.
# Optional value. Default: false.
#
# [*owner*]
# Name of the owner of the certificates.
# Optional value. Default: 'root'.
#
# [*service*]
# Name of the server service to notify when certificates are updated.
# Setting to `undef` will disable service notifications.
# Optional value. Defaults:
#   - 'httpd' for RedHat-based systems
#   - 'apache2' for Debian-based, Suse-based, and Gentoo-based systems
#   - 'apache24' for FreeBSD-based systems
#
# [*source_path*]
# The location of the certificate files. Typically references a module's files.
# e.g. 'puppet:///site_certs' will search for the mount point defined in the
# fileserver.conf on the Puppet Server for the specified files.
#
# === Examples
#
#  Without Hiera:
#
#    include certs
#    $cname = www.example.com
#    certs::site { $cname:
#        source_path    => 'puppet:///site_certificates',
#        ca_cert        => true,
#        ca_name        => 'caname',
#        ca_source_path => 'puppet:///ca_certs',
#    }
#
#  With Hiera:
#
#    server.yaml
#    ---
#    classes:
#        - certs
#    certs::sites:
#        'www.example.com':
#            source_path: 'puppet:///site_certificates'
#            ca_cert: true
#            ca_name: 'caname'
#            ca_source_path: 'puppet:///ca_certs'
#
#  Resource Chaining with Apache Module
#
#    manifest.pp
#    ---
#    Certs::Site<| |> -> Apache::Vhost<| |>
#
# === Authors
#
# Riccardo Calixte <rcalixte@broadinstitute.org>
# Andrew Teixeira <teixeira@broadinstitute.org>
#
# === Copyright
#
# Copyright 2018
#
define certs::site(
  Enum['present','absent'] $ensure    = 'present',
  Optional[String] $source_path       = undef,
  Stdlib::Absolutepath $cert_path     = $::certs::cert_path,
  String $cert_dir_mode               = $::certs::cert_dir_mode,
  String $cert_ext                    = $::certs::cert_ext,
  String $cert_mode                   = $::certs::cert_mode,
  Optional[String] $cert_content      = undef,
  Stdlib::Absolutepath $key_path      = $::certs::key_path,
  String $key_dir_mode                = $::certs::key_dir_mode,
  String $key_ext                     = $::certs::key_ext,
  String $key_mode                    = $::certs::key_mode,
  Boolean $merge_key                  = false,
  Optional[String] $key_content       = undef,
  Boolean $ca_cert                    = false,
  Optional[String] $ca_name           = undef,
  Optional[String] $ca_source_path    = $source_path,
  Stdlib::Absolutepath $ca_path       = $::certs::ca_path,
  String $ca_ext                      = $::certs::ca_ext,
  Optional[String] $ca_content        = undef,
  Boolean $cert_chain                 = false,
  Optional[String] $chain_name        = undef,
  Stdlib::Absolutepath $chain_path    = $::certs::chain_path,
  String $chain_ext                   = $::certs::chain_ext,
  Optional[String] $chain_source_path = $source_path,
  Optional[String] $chain_content     = undef,
  Boolean $merge_chain                = false,
  Boolean $dhparam                    = false,
  Optional[String] $dhparam_content   = undef,
  String $dhparam_file                = $::certs::dhparam_file,
  Boolean $merge_dhparam              = false,
  Optional[String] $service           = undef,
  String $owner                       = $::certs::owner,
  String $group                       = $::certs::group,
) {
  # The base class must be included first because it is used by parameter defaults
  unless defined(Class['certs']) {
    fail('You must include the certs base class before using any certs defined resources')
  }

  if ($source_path == undef and ($cert_content == undef or $key_content == undef)) {
    fail('You must provide a source_path or cert_content/key_content combination for the SSL files to certs::site.')
  }

  if ($source_path and ($cert_content or $key_content)) {
    fail('You can only provide $source_path or $cert_content/$key_content, not both.')
  }

  unless $source_path {
    unless($cert_content and $key_content) {
      fail('If source_path is not set, $cert_content and $key_content must both be set.')
    }
  }

  $cert = "${name}${cert_ext}"
  $key  = "${name}${key_ext}"

  case $source_path {
    undef: {
      $cert_source = undef
      $key_source = undef
    }
    default: {
      $cert_source = "${source_path}/${cert}"
      $key_source  = "${source_path}/${key}"
    }
  }

  $dhparam_source = $dhparam_content ? {
    undef   => "${source_path}/${dhparam_file}",
    default => undef,
  }

  if $cert_chain {
    if ($chain_name == undef) {
      fail('You must provide a chain_name value for the cert chain to certs::site.')
    }
    $chain = "${chain_name}${chain_ext}"

    if $chain_content == undef {
      if ($chain_source_path == undef) {
        fail('You must provide a chain_source_path for the SSL files to certs::site.')
      }

      $chain_source = "${chain_source_path}/${chain}"
    } else {
      $chain_source = undef
    }
    case $ca_path {
      /etc\/pki\/ca-trust/: {
        $exec_notify = Exec['update_ca_trust']
      }
      default: {
        $exec_notify = undef
      }
    }
  }

  if $ca_cert {
    if ($ca_name == undef) {
      fail('You must provide a ca_name value for the CA cert to certs::site.')
    }
    $ca = "${ca_name}${ca_ext}"

    if $ca_content == undef {
      if ($ca_source_path == undef) {
        fail('You must provide a ca_source_path for the SSL files to certs::site.')
      }

      $ca_source = "${ca_source_path}/${ca}"
    } else {
      $ca_source = undef
    }
  }

  case $service {
    undef: {
      $service_notify = undef
    }
    default: {
      $service_notify = Service[$service]
    }
  }

  ensure_resource('file', [$cert_path, $chain_path, $ca_path], {
    ensure => 'directory',
    backup => false,
    owner  => $owner,
    group  => $group,
    mode   => $cert_dir_mode,
  })

  ensure_resource('file', $key_path, {
    ensure => 'directory',
    backup => false,
    owner  => $owner,
    group  => $group,
    mode   => $key_dir_mode,
  })

  if $merge_chain or $merge_key or $merge_dhparam {
    concat { "${name}_cert_merged":
        ensure         => $ensure,
        ensure_newline => true,
        backup         => false,
        path           => "${cert_path}/${cert}",
        owner          => $owner,
        group          => $group,
        mode           => $cert_mode,
        require        => File[$cert_path],
        notify         => $service_notify,
    }

    concat::fragment { "${cert}_certificate":
      target  => "${name}_cert_merged",
      source  => $cert_source,
      content => $cert_content,
      order   => '01',
    }

    if $merge_key {
      concat::fragment { "${cert}_key":
        target  => "${name}_cert_merged",
        source  => $key_source,
        content => $key_content,
        order   => '02',
      }
    }

    if $merge_chain {
      if $cert_chain {
        concat::fragment { "${cert}_chain":
          target  => "${name}_cert_merged",
          source  => $chain_source,
          content => $chain_content,
          order   => '50',
        }
      }
      if $ca_cert {
        concat::fragment { "${cert}_ca":
          target  => "${name}_cert_merged",
          source  => $ca_source,
          content => $ca_content,
          order   => '90',
        }
      }
    }

    if $dhparam and $merge_dhparam {
      concat::fragment { "${cert}_dhparam":
        target  => "${name}_cert_merged",
        source  => $dhparam_source,
        content => $dhparam_content,
        order   => '95',
      }
    }
  } else {
    file { "${cert_path}/${cert}":
        ensure  => $ensure,
        source  => $cert_source,
        content => $cert_content,
        owner   => $owner,
        group   => $group,
        mode    => $cert_mode,
        require => File[$cert_path],
        notify  => $service_notify,
    }
  }

  file { "${key_path}/${key}":
    ensure  => $ensure,
    source  => $key_source,
    content => $key_content,
    owner   => $owner,
    group   => $group,
    mode    => $key_mode,
    require => File[$key_path],
    notify  => $service_notify,
  }

  if ($cert_chain) {
    ensure_resource('file', "${chain_path}/${chain}", {
      ensure  => 'file',
      source  => $chain_source,
      content => $chain_content,
      owner   => $owner,
      group   => $group,
      mode    => $cert_mode,
      require => File[$chain_path],
      notify  => $service_notify,
    })
  }

  if ($ca_cert) {
    ensure_resource('file', "${ca_path}/${ca}", {
      ensure  => 'file',
      source  => $ca_source,
      content => $ca_content,
      owner   => $owner,
      group   => $group,
      mode    => $cert_mode,
      require => File[$ca_path],
      notify  => $service_notify,
    })
  }

  if ($dhparam) {
    ensure_resource('file', "${cert_path}/${name}_${dhparam_file}", {
      ensure  => $ensure,
      source  => $dhparam_source,
      content => $dhparam_content,
      owner   => $owner,
      group   => $group,
      mode    => $cert_mode,
      require => File[$cert_path],
      notify  => $service_notify,
    })
  }
}
