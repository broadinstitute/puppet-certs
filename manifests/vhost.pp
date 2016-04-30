# == Define: certs::vhost
#
# SSL Certificate File Management
#
# Intended to be used in conjunction with puppetlabs/apache's apache::vhost
# definitions, to provide the ssl_cert and ssl_key files.
#
# === Examples
#
#  Without Hiera:
#
#    include certs::params
#    $cname = www.example.com
#    certs::vhost{ $cname:
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
#      - certs::params
#    certs::vhosts:
#      'www.example.com':
#        source_path: 'puppet:///site_certificates'
#        ca_cert: true
#        ca_name: 'caname'
#        ca_source_path: 'puppet:///ca_certs'
#
#    manifest.pp
#    ---
#    $certs = hiera_hash('certs::vhosts', {})
#    create_resources('certs::vhost', $certs)
#    Certs::Vhost<| |> -> Apache::Vhost<| |>
#
# === Authors
#
# Rob Nelson <rnelson0@gmail.com>
#
# === Copyright
#
# Copyright 2014 Rob Nelson
#
define certs::vhost(
  $source_path       = undef,
  $cert_ext          = $::certs::params::cert_ext,
  $cert_path         = $::certs::params::cert_path,
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
) {
  if ($name == undef) {
    fail('You must provide a name value for the vhost to certs::vhost.')
  }
  if ($source_path == undef) {
    fail('You must provide a source_path for the SSL files to certs::vhost.')
  }
  validate_absolute_path($cert_path)
  validate_absolute_path($keys_path)
  validate_bool($cert_chain)
  if $cert_chain {
    if ($chain_name == undef) {
      fail('You must provide a chain_name value for the cert chain to certs::vhost.')
    }
    validate_absolute_path($chain_path)
    if ($chain_source_path == undef) {
      fail('You must provide a chain_source_path for the SSL files to certs::vhost.')
    }
  }
  validate_bool($ca_cert)
  if $ca_cert {
    if ($ca_name == undef) {
      fail('You must provide a ca_name value for the CA cert to certs::vhost.')
    }
    validate_absolute_path($ca_path)
    if ($ca_source_path == undef) {
      fail('You must provide a ca_source_path for the SSL files to certs::vhost.')
    }
  }
  validate_string($owner, $group)
  validate_numeric($cert_mode)
  validate_numeric($key_mode)

  $cert = "${name}${cert_ext}"
  $key = "${name}.key"
  if $cert_chain { $chain = "${chain_name}${chain_ext}" }
  if $ca_cert { $ca = "${ca_name}${ca_ext}" }

  if (defined(Service[$service]) and $service != '') {
    validate_string($service)

    File["${cert_path}/${cert}"] ~> Service[$service]
    File["${keys_path}/${key}"] ~> Service[$service]

    if $cert_chain {
      File["${chain_path}/${chain}"] ~> Service[$service]
    }

    if $ca_cert {
      File ["${ca_path}/${ca}"] ~> Service[$service]
    }
  }

  file { "${cert_path}/${cert}":
    ensure => file,
    source => "${source_path}/${cert}",
    owner  => $owner,
    group  => $group,
    mode   => $cert_mode,
  } ->
  file { "${keys_path}/${key}":
    ensure => file,
    source => "${source_path}/${key}",
    owner  => $owner,
    group  => $group,
    mode   => $key_mode,
  }

  if ($cert_chain and !defined(File["${chain_path}/${chain}"])) {
    file { "${chain_path}/${chain}":
      ensure => file,
      source => "${chain_source_path}/${chain}",
      owner  => $owner,
      group  => $group,
      mode   => $cert_mode,
    }
  }

  if ($ca_cert and !defined(File["${ca_path}/${ca}"])) {
    file { "${ca_path}/${ca}":
      ensure => file,
      source => "${ca_source_path}/${ca}",
      owner  => $owner,
      group  => $group,
      mode   => $cert_mode,
    }
  }
}
