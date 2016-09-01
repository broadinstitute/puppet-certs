# == Define: certs::site
#
# Puppet module for SSL certificate installation
#
# Can be used in conjunction with puppetlabs/apache's apache::vhost
# definitions, to provide the ssl_cert and ssl_key files, or any
# other service requiring SSL certificates. It can also be used
# independent of any Puppet-defined service.
#
# === Examples
#
#  Without Hiera:
#
#    include certs
#    $cname = www.example.com
#    certs::site { $cname:
#      source_path    => 'puppet:///site_certificates',
#      ca_cert        => true,
#      ca_name        => 'caname',
#      ca_source_path => 'puppet:///ca_certs',
#    }
#
#  With Hiera:
#
#    server.yaml
#    ---
#    classes:
#      - certs
#    certs::sites:
#      'www.example.com':
#        source_path: 'puppet:///site_certificates'
#        ca_cert: true
#        ca_name: 'caname'
#        ca_source_path: 'puppet:///ca_certs'
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
# Copyright 2016
#
define certs::site(
  $source_path       = undef,
  $cert_ext          = $::certs::params::cert_ext,
  $cert_path         = $::certs::params::cert_path,
  $key_ext           = $::certs::params::key_ext,
  $keys_path         = $::certs::params::keys_path,
  $cert_chain        = $::certs::params::cert_chain,
  $chain_name        = $::certs::params::chain_name,
  $chain_ext         = $::certs::params::chain_ext,
  $chain_path        = $::certs::params::chain_path,
  $chain_source_path = $source_path,
  $ca_cert           = $::certs::params::ca_cert,
  $ca_name           = $::certs::params::ca_name,
  $ca_ext            = $::certs::params::ca_ext,
  $ca_path           = $::certs::params::ca_path,
  $ca_source_path    = $source_path,
  $service           = $::certs::params::service,
  $owner             = $::certs::params::owner,
  $group             = $::certs::params::group,
  $cert_mode         = $::certs::params::cert_mode,
  $key_mode          = $::certs::params::key_mode,
  $cert_dir_mode     = $::certs::params::cert_dir_mode,
  $key_dir_mode      = $::certs::params::key_dir_mode,
  $merge_chain       = $::certs::params::merge_chain,
) {
  if ($name == undef) {
    fail('You must provide a name value for the site to certs::site.')
  }
  if ($source_path == undef) {
    fail('You must provide a source_path for the SSL files to certs::site.')
  }
  validate_absolute_path($cert_path)
  validate_absolute_path($keys_path)
  validate_bool($cert_chain)
  if $cert_chain {
    if ($chain_name == undef) {
      fail('You must provide a chain_name value for the cert chain to certs::site.')
    }
    validate_absolute_path($chain_path)
    if ($chain_source_path == undef) {
      fail('You must provide a chain_source_path for the SSL files to certs::site.')
    }
  }
  validate_bool($ca_cert)
  if $ca_cert {
    if ($ca_name == undef) {
      fail('You must provide a ca_name value for the CA cert to certs::site.')
    }
    validate_absolute_path($ca_path)
    if ($ca_source_path == undef) {
      fail('You must provide a ca_source_path for the SSL files to certs::site.')
    }
  }
  validate_string($owner, $group)
  validate_string($cert_mode)
  validate_numeric($cert_mode)
  validate_string($key_mode)
  validate_numeric($key_mode)
  validate_string($cert_dir_mode)
  validate_numeric($cert_dir_mode)
  validate_string($key_dir_mode)
  validate_numeric($key_dir_mode)
  validate_bool($merge_chain)

  $cert = "${name}${cert_ext}"
  $key = "${name}${key_ext}"

  if $cert_chain {
    $chain = "${chain_name}${chain_ext}"
  }
  if $ca_cert {
    $ca = "${ca_name}${ca_ext}"
  }

  if $service != '' {
    if defined(Service[$service]) {
      $service_notify = Service[$service]
    } else {
      $service_notify = undef
    }
  }

  if !defined(File[$cert_path]) {
    file { $cert_path:
      ensure => 'directory',
      backup => false,
      owner  => $owner,
      group  => $group,
      mode   => $cert_dir_mode,
    }
  }

  if !defined(File[$chain_path]) {
    file { $chain_path:
      ensure => 'directory',
      backup => false,
      owner  => $owner,
      group  => $group,
      mode   => $cert_dir_mode,
    }
  }

  if !defined(File[$ca_path]) {
    file { $ca_path:
      ensure => 'directory',
      backup => false,
      owner  => $owner,
      group  => $group,
      mode   => $cert_dir_mode,
    }
  }

  if !defined(File[$keys_path]) {
    file { $keys_path:
      ensure => 'directory',
      backup => false,
      owner  => $owner,
      group  => $group,
      mode   => $key_dir_mode,
    }
  }

  if $merge_chain {
    concat { "${name}_cert_merged":
      ensure         => 'present',
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
      target => "${name}_cert_merged",
      source => "${source_path}/${cert}",
      order  => '01'
    }

    if $cert_chain {
      concat::fragment { "${cert}_chain":
        target => "${name}_cert_merged",
        source => "${chain_source_path}/${chain}",
        order  => '50'
      }
    }
    if $ca_cert {
      concat::fragment { "${cert}_ca":
        target => "${name}_cert_merged",
        source => "${ca_source_path}/${ca}",
        order  => '90'
      }
    }
  } else {
    file { "${cert_path}/${cert}":
      ensure  => file,
      source  => "${source_path}/${cert}",
      owner   => $owner,
      group   => $group,
      mode    => $cert_mode,
      require => File[$cert_path],
      notify  => $service_notify,
    }
  }

  file { "${keys_path}/${key}":
    ensure  => file,
    source  => "${source_path}/${key}",
    owner   => $owner,
    group   => $group,
    mode    => $key_mode,
    require => File[$keys_path],
    notify  => $service_notify,
  }

  if ($cert_chain and !defined(File["${chain_path}/${chain}"])) {
    file { "${chain_path}/${chain}":
      ensure  => file,
      source  => "${chain_source_path}/${chain}",
      owner   => $owner,
      group   => $group,
      mode    => $cert_mode,
      require => File[$chain_path],
      notify  => $service_notify,
    }
  }

  if ($ca_cert and !defined(File["${ca_path}/${ca}"])) {
    file { "${ca_path}/${ca}":
      ensure  => file,
      source  => "${ca_source_path}/${ca}",
      owner   => $owner,
      group   => $group,
      mode    => $cert_mode,
      require => File[$ca_path],
      notify  => $service_notify,
    }
  }
}
