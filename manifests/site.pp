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
  validate_numeric($cert_mode)
  validate_numeric($key_mode)

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

  file { "${cert_path}/${cert}":
    ensure => file,
    source => "${source_path}/${cert}",
    owner  => $owner,
    group  => $group,
    mode   => $cert_mode,
    notify => $service_notify,
  } ->
  file { "${keys_path}/${key}":
    ensure => file,
    source => "${source_path}/${key}",
    owner  => $owner,
    group  => $group,
    mode   => $key_mode,
    notify => $service_notify,
  }

  if ($cert_chain and !defined(File["${chain_path}/${chain}"])) {
    file { "${chain_path}/${chain}":
      ensure => file,
      source => "${chain_source_path}/${chain}",
      owner  => $owner,
      group  => $group,
      mode   => $cert_mode,
      notify => $service_notify,
    }
  }

  if ($ca_cert and !defined(File["${ca_path}/${ca}"])) {
    file { "${ca_path}/${ca}":
      ensure => file,
      source => "${ca_source_path}/${ca}",
      owner  => $owner,
      group  => $group,
      mode   => $cert_mode,
      notify => $service_notify,
    }
  }
}
