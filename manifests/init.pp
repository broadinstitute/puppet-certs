# == Class: certs
#
# The certs class provides a single define, certs::vhost. The certs class
# itself should never be instantiated.
#
# === Authors
#
# Rob Nelson <rnelson0@gmail.com>
#
# === Copyright
#
# Copyright 2014 Rob Nelson
#
class certs inherits ::certs::params {
  # Empty class. The module provides the certs::vhost resource instead.
}
