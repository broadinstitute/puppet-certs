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
class certs (
  $cert_ext      = undef,
  $cert_path     = undef,
  $key_ext       = undef,
  $key_path      = undef,
  $chain_ext     = undef,
  $chain_path    = undef,
  $ca_ext        = undef,
  $ca_path       = undef,
  $service       = undef,
  $owner         = undef,
  $group         = undef,
  $cert_mode     = undef,
  $key_mode      = undef,
  $cert_dir_mode = undef,
  $key_dir_mode  = undef,
  $sites         = hiera_hash('certs::sites', {}),
) {

  include ::certs::params

  $_cert_ext      = pick_default($cert_ext, $::certs::params::cert_ext)
  $_cert_path     = pick_default($cert_path, $::certs::params::cert_path)
  $_key_ext       = pick_default($key_ext, $::certs::params::key_ext)
  $_key_path      = pick_default($key_path, $::certs::params::key_path)
  $_chain_ext     = pick_default($chain_ext, $::certs::params::chain_ext)
  $_chain_path    = pick_default($chain_path, $::certs::params::chain_path)
  $_ca_ext        = pick_default($ca_ext, $::certs::params::ca_ext)
  $_ca_path       = pick_default($ca_path, $::certs::params::ca_path)
  $_service       = pick_default($service, $::certs::params::service)
  $_owner         = pick_default($owner, $::certs::params::owner)
  $_group         = pick_default($group, $::certs::params::group)
  $_cert_mode     = pick_default($cert_mode, $::certs::params::cert_mode)
  $_key_mode      = pick_default($key_mode, $::certs::params::key_mode)
  $_cert_dir_mode = pick_default($cert_dir_mode, $::certs::params::cert_dir_mode)
  $_key_dir_mode  = pick_default($key_dir_mode, $::certs::params::key_dir_mode)

  validate_string($_cert_ext)
  validate_absolute_path($_cert_path)
  validate_string($_key_ext)
  validate_absolute_path($_key_path)
  validate_string($_chain_ext)
  validate_absolute_path($_chain_path)
  validate_string($_ca_ext)
  validate_absolute_path($_ca_path)

  if $service != undef {
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

  create_resources('certs::site', $sites)
}
