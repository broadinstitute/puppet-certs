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
class certs (
  $sites = hiera_hash('certs::sites', {}),
) {

    include ::certs::params

    create_resources('certs::site', $sites)
}
