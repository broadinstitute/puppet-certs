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
  $cert_ext          = undef,
  $cert_path         = undef,
  $key_ext           = undef,
  $key_path          = undef,
  $cert_chain        = false,
  $chain_name        = undef,
  $chain_ext         = undef,
  $chain_path        = undef,
  $chain_source_path = $source_path,
  $ca_cert           = false,
  $ca_name           = undef,
  $ca_ext            = undef,
  $ca_path           = undef,
  $ca_source_path    = $source_path,
  $service           = undef,
  $owner             = undef,
  $group             = undef,
  $cert_mode         = undef,
  $key_mode          = undef,
  $cert_dir_mode     = undef,
  $key_dir_mode      = undef,
  $merge_chain       = false,
) {

  # The base class must be included first because it is used by parameter defaults
  if ! defined(Class['certs']) {
    fail('You must include the certs base class before using any certs defined resources')
  }

  if ($name == undef) {
    fail('You must provide a name value for the site to certs::site.')
  }
  if ($source_path == undef) {
    fail('You must provide a source_path for the SSL files to certs::site.')
  }

  $_cert_ext      = pick_default($cert_ext, $::certs::_cert_ext)
  $_cert_path     = pick_default($cert_path, $::certs::_cert_path)
  $_key_ext       = pick_default($key_ext, $::certs::_key_ext)
  $_key_path      = pick_default($key_path, $::certs::_key_path)
  $_chain_ext     = pick_default($chain_ext, $::certs::_chain_ext)
  $_chain_path    = pick_default($chain_path, $::certs::_chain_path)
  $_ca_ext        = pick_default($ca_ext, $::certs::_ca_ext)
  $_ca_path       = pick_default($ca_path, $::certs::_ca_path)
  $_service       = pick_default($service, $::certs::_service)
  $_owner         = pick_default($owner, $::certs::_owner)
  $_group         = pick_default($group, $::certs::_group)
  $_cert_mode     = pick_default($cert_mode, $::certs::_cert_mode)
  $_key_mode      = pick_default($key_mode, $::certs::_key_mode)
  $_cert_dir_mode = pick_default($cert_dir_mode, $::certs::_cert_dir_mode)
  $_key_dir_mode  = pick_default($key_dir_mode, $::certs::_key_dir_mode)

  validate_string($_cert_ext)
  validate_absolute_path($_cert_path)
  validate_string($_key_ext)
  validate_absolute_path($_key_path)
  validate_string($_chain_ext)
  validate_absolute_path($_chain_path)
  validate_string($_ca_ext)
  validate_absolute_path($_ca_path)

  if $service != '' {
    validate_string($service)
  }

  validate_string($_owner)
  validate_string($_group)
  validate_string($_cert_mode)
  validate_numeric($_cert_mode)
  validate_string($_key_mode)
  validate_numeric($_key_mode)
  validate_string($_cert_dir_mode)
  validate_numeric($_cert_dir_mode)
  validate_string($_key_dir_mode)
  validate_numeric($_key_dir_mode)

  validate_bool($cert_chain)
  if $cert_chain {
    if ($chain_name == undef) {
      fail('You must provide a chain_name value for the cert chain to certs::site.')
    }
    if ($chain_source_path == undef) {
      fail('You must provide a chain_source_path for the SSL files to certs::site.')
    }
  }

  validate_bool($ca_cert)
  if $ca_cert {
    if ($ca_name == undef) {
      fail('You must provide a ca_name value for the CA cert to certs::site.')
    }

    if ($ca_source_path == undef) {
      fail('You must provide a ca_source_path for the SSL files to certs::site.')
    }
  }

  validate_bool($merge_chain)

  $cert = "${name}${_cert_ext}"
  $key  = "${name}${_key_ext}"

  if $cert_chain {
    $chain = "${chain_name}${_chain_ext}"
  }
  if $ca_cert {
    $ca = "${ca_name}${_ca_ext}"
  }

  if $service != '' {
    if defined(Service[$service]) {
      $service_notify = Service[$service]
    } else {
      $service_notify = undef
    }
  }

  if !defined(File[$_cert_path]) {
    file { $_cert_path:
      ensure => 'directory',
      backup => false,
      owner  => $_owner,
      group  => $_group,
      mode   => $_cert_dir_mode,
    }
  }

  if !defined(File[$_chain_path]) {
    file { $_chain_path:
      ensure => 'directory',
      backup => false,
      owner  => $_owner,
      group  => $_group,
      mode   => $_cert_dir_mode,
    }
  }

  if !defined(File[$_ca_path]) {
    file { $_ca_path:
      ensure => 'directory',
      backup => false,
      owner  => $_owner,
      group  => $_group,
      mode   => $_cert_dir_mode,
    }
  }

  if !defined(File[$_key_path]) {
    file { $_key_path:
      ensure => 'directory',
      backup => false,
      owner  => $_owner,
      group  => $_group,
      mode   => $_key_dir_mode,
    }
  }

  if $merge_chain {
    concat { "${name}_cert_merged":
      ensure         => 'present',
      ensure_newline => true,
      backup         => false,
      path           => "${_cert_path}/${cert}",
      owner          => $_owner,
      group          => $_group,
      mode           => $_cert_mode,
      require        => File[$_cert_path],
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
    file { "${_cert_path}/${cert}":
      ensure  => file,
      source  => "${source_path}/${cert}",
      owner   => $_owner,
      group   => $_group,
      mode    => $_cert_mode,
      require => File[$_cert_path],
      notify  => $service_notify,
    }
  }

  file { "${_key_path}/${key}":
    ensure  => file,
    source  => "${source_path}/${key}",
    owner   => $_owner,
    group   => $_group,
    mode    => $_key_mode,
    require => File[$_key_path],
    notify  => $service_notify,
  }

  if ($cert_chain and !defined(File["${_chain_path}/${chain}"])) {
    file { "${_chain_path}/${chain}":
      ensure  => file,
      source  => "${chain_source_path}/${chain}",
      owner   => $_owner,
      group   => $_group,
      mode    => $_cert_mode,
      require => File[$_chain_path],
      notify  => $service_notify,
    }
  }

  if ($ca_cert and !defined(File["${_ca_path}/${ca}"])) {
    file { "${_ca_path}/${ca}":
      ensure  => file,
      source  => "${ca_source_path}/${ca}",
      owner   => $_owner,
      group   => $_group,
      mode    => $_cert_mode,
      require => File[$_ca_path],
      notify  => $service_notify,
    }
  }
}
