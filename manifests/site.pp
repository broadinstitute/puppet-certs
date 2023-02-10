#
# @summary Puppet module for SSL certificate installation.
# Can be used in conjunction with puppetlabs/apache's apache::vhost
# definitions, to provide the ssl_cert and ssl_key files, or any
# other service requiring SSL certificates. It can also be used
# independent of any Puppet-defined service.
#
# @example Without Hiera
#   include certificates
#   $cname = 'www.example.com'
#   certificates::site { $cname:
#     ca_cert        => true,
#     ca_name        => 'caname',
#     ca_source_path => 'puppet:///ca_certs',
#     source_path    => 'puppet:///site_certificates',
#   }
#
# @example With Hiera
#   ---
#   classes:
#     - certificates
#   certificates::sites:
#     'www.example.com':
#       ca_cert: true
#       ca_name: 'caname'
#       ca_source_path: 'puppet:///ca_certs'
#       source_path: 'puppet:///site_certificates'
#
# @example Resource Chaining with Apache Module
#   Certificates::Site<| |> -> Apache::Vhost<| |>
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
#   Optional value. (default: 'crt').
#
# @param ca_name
#   The name of the CA certificate file.
#   Optional value. (default: undef).
#
# @param ca_path
#   Location where the CA certificate file will be stored on the managed node.
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
#   Optional value. (default: '0755').
#
# @param cert_ext
#   The extension of the certificate file.
#   Optional value. (default: '.crt').
#
# @param cert_mode
#   Permissions of the certificate files.
#   Optional value. (default: '0644').
#
# @param cert_path
#   Location where the certificate files will be stored on the managed node.
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
#   Optional value. (default: 'crt').
#
# @param chain_name
#   The name of the certificate chain file.
#   Optional value. (default: undef).
#
# @param chain_path
#   Location where the certificate chain file will be stored on the managed node.
#   Optional value. (default: `$cert_path`).
#
# @param chain_source_path
#   The location of the certificate chain file. Typically references a module's files.
#   e.g. `puppet:///chain_certs` will search for the mount point defined in the
#   fileserver.conf on the Puppet Server for the specified files.
#   Optional value. (default: `$source_path`).
#
# @param dhparam
#   A boolean value to determine whether a dhparam file should be placed on the
#   system along with the other certificate files.  The dhparam file will need to
#   exist on the source side just as with the other certificate files in order
#   for the file to be delivered.
#   Optional value. (default: false).
#
# @param dhparam_content
#   A string representing the contents of the dhparam file.  This option will
#   take precedence over dhparam_file if it exists on the source side.
#   Optional value. (default: undef).
#
# @param dhparam_dir
#   The directory in which the dhparam file should be placed.
#   Optional value. (default: `$cert_path`).
#
# @param dhparam_file
#   The name of the dhparam file.
#   Optional value. (default: 'dh2048.pem').
#
# @param ensure
#   Ensure for the site resources.  If 'present', files will be put in place.  If
#   'absent', files will be removed.
#   Optional value. (default: 'present').
#
# @param group
#   Name of the group owner of the certificates.
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
#   Optional value. (default: '0755').
#
# @param key_ext
#   The extension of the private key file.
#   Optional value. (default: '.key').
#
# @param key_mode
#   Permissions of the private keys.
#   Optional value. (default: '0600').
#
# @param key_path
#   Location where the private keys will be stored on the managed node.
#   Optional value. Defaults:
#     - `/etc/pki/tls/private` on RedHat-based systems
#     - `/etc/ssl/private` on Debian-based and Suse-based systems
#     - `/usr/local/etc/apache24` on FreeBSD-based systems
#     - `/etc/ssl/apache2` on Gentoo-based systems
#
# @param merge_chain
#   Option to merge the CA and chain files into the actual certificate file,
#   which is required by some software.
#   Optional value. (default: false).
#
# @param merge_dhparam
#   Option to merge the DH paramaters file into the actual certificate file,
#   which is required by some software.
#   Optional value. (default: false).
#
# @param merge_key
#   Option to merge the private into the actual certificate file, which is
#   required by some software.
#   Optional value. (default: false).
#
# @param owner
#   Name of the owner of the certificates.
#   Optional value. (default: 'root').
#
# @param service
#   Name of the server service(s) to notify when certificates are updated.
#   Setting to false (or any Boolean) will disable service notifications.
#   Optional value. Defaults:
#     - `httpd` for RedHat-based systems
#     - `apache2` for Debian-based, Suse-based, and Gentoo-based systems
#     - `apache24` for FreeBSD-based systems
#
# @param source_cert_name
#   The name of the source certificate file.
#   Optional value. (default: `$namevar`).
#
# @param source_key_name
#   The name of the source key file.
#   Optional value. (default: `$namevar`).
#
# @param source_path
#   The location of the certificate files. Typically references a module's files.
#   e.g. `puppet:///site_certs` will search for the mount point defined in the
#   fileserver.conf on the Puppet Server for the specified files.
#
# @param validate_x509
#   A boolean value to determine whether or not to validate the certificate and key pairs.
#   Failure will cause the catalog to fail compilation.
#   Optional value. (default: false).
#
define certificates::site (
  Enum['present','absent'] $ensure                         = 'present',
  Boolean $ca_cert                                         = $::certificates::ca_cert,
  Optional[String] $ca_content                             = $::certificates::ca_content,
  String $ca_ext                                           = $::certificates::ca_ext,
  Optional[String] $ca_name                                = $::certificates::ca_name,
  Stdlib::Absolutepath $ca_path                            = $::certificates::ca_path,
  Boolean $cert_chain                                      = $::certificates::cert_chain,
  Optional[String] $cert_content                           = $::certificates::cert_content,
  String $cert_dir_mode                                    = $::certificates::cert_dir_mode,
  String $cert_ext                                         = $::certificates::cert_ext,
  String $cert_mode                                        = $::certificates::cert_mode,
  Stdlib::Absolutepath $cert_path                          = $::certificates::cert_path,
  Optional[String] $chain_content                          = $::certificates::chain_content,
  String $chain_ext                                        = $::certificates::chain_ext,
  Optional[String] $chain_name                             = $::certificates::chain_name,
  Stdlib::Absolutepath $chain_path                         = $::certificates::chain_path,
  Boolean $dhparam                                         = false,
  Optional[String] $dhparam_content                        = undef,
  Optional[Stdlib::Absolutepath] $dhparam_dir              = undef,
  String $dhparam_file                                     = $::certificates::dhparam_file,
  String $group                                            = $::certificates::group,
  Optional[String] $key_content                            = $::certificates::key_content,
  String $key_dir_mode                                     = $::certificates::key_dir_mode,
  String $key_ext                                          = $::certificates::key_ext,
  String $key_mode                                         = $::certificates::key_mode,
  Stdlib::Absolutepath $key_path                           = $::certificates::key_path,
  Boolean $merge_chain                                     = false,
  Boolean $merge_dhparam                                   = false,
  Boolean $merge_key                                       = false,
  String $owner                                            = $::certificates::owner,
  Optional[Variant[Array[String],Boolean,String]] $service = $::certificates::service,
  Optional[String] $source_cert_name                       = undef,
  Optional[String] $source_key_name                        = undef,
  Optional[String] $source_path                            = $::certificates::source_path,
  Boolean $validate_x509                                   = $::certificates::validate_x509,
  Optional[String] $ca_source_path                         = pick_default($::certificates::ca_source_path, $source_path),
  Optional[String] $chain_source_path                      = pick_default($::certificates::chain_source_path, $source_path),
) {
  # The base class must be included first because it is used by parameter defaults
  unless (defined(Class['certificates'])) {
    fail('You must include the certificates base class before using any certificates defined resources')
  }

  if ($source_path == undef and ($cert_content == undef or $key_content == undef)) {
    fail('You must provide a source_path or cert_content/key_content combination for the SSL files to certificates::site.')
  }

  if ($source_path and ($cert_content or $key_content)) {
    fail('You can only provide $source_path or $cert_content/$key_content, not both.')
  }

  unless ($source_path) {
    unless($cert_content and $key_content) {
      fail('If source_path is not set, $cert_content and $key_content must both be set.')
    }
  }

  $cert = "${name}${cert_ext}"
  $key  = "${name}${key_ext}"

  if $source_cert_name {
    $cert_src = "${source_cert_name}${cert_ext}"
  } else {
    $cert_src = $cert
  }
  if $source_key_name {
    $key_src  = "${source_key_name}${key_ext}"
  } else {
    $key_src = $key
  }

  if ($validate_x509) {
    validate_x509_rsa_key_pair("${cert_path}/${cert}", "${key_path}/${key}")
  }

  case $source_path {
    undef: {
      $cert_source = undef
      $key_source = undef
    }
    default: {
      $cert_source = "${source_path}/${cert_src}"
      $key_source  = "${source_path}/${key_src}"
    }
  }

  $dhparam_source = $dhparam_content ? {
    undef   => "${source_path}/${dhparam_file}",
    default => undef,
  }

  if ($cert_chain) {
    if ($chain_name == undef) {
      fail('You must provide a chain_name value for the cert chain to certificates::site.')
    }
    $chain = "${chain_name}${chain_ext}"

    if ($chain_content == undef) {
      if ($chain_source_path == undef) {
        fail('You must provide a chain_source_path for the SSL files to certificates::site.')
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

  if ($ca_cert) {
    if ($ca_name == undef) {
      fail('You must provide a ca_name value for the CA cert to certificates::site.')
    }
    $ca = "${ca_name}${ca_ext}"

    if ($ca_content == undef) {
      if ($ca_source_path == undef) {
        fail('You must provide a ca_source_path for the SSL files to certificates::site.')
      }

      $ca_source = "${ca_source_path}/${ca}"
    } else {
      $ca_source = undef
    }
  }

  if ($service =~ String) {
    $service_notify = Service[$service]
  } elsif ($service =~ Boolean) {
    $service_notify = undef
  } elsif ($service =~ Array[String]) {
    $service_notify = $service.map |$serv| {
      "Service[${serv}]"
    }
  }

  if (! defined(File[$cert_path])) {
    file { $cert_path:
      ensure => 'directory',
      backup => false,
      owner  => $owner,
      group  => $group,
      mode   => $cert_dir_mode,
    }
  }

  if (! defined(File[$chain_path])) {
    file { $chain_path:
      ensure => 'directory',
      backup => false,
      owner  => $owner,
      group  => $group,
      mode   => $cert_dir_mode,
    }
  }

  if (! defined(File[$ca_path])) {
    file { $ca_path:
      ensure => 'directory',
      backup => false,
      owner  => $owner,
      group  => $group,
      mode   => $cert_dir_mode,
    }
  }

  ensure_resource('file', $key_path, {
    ensure => 'directory',
    backup => false,
    owner  => $owner,
    group  => $group,
    mode   => $key_dir_mode,
  })

  if ($merge_key) {
    $substring_mode = $cert_mode[0,-3]
    $_cert_mode = "${substring_mode}00"
    $_cert_path = $key_path
  } else {
    $_cert_mode = $cert_mode
    $_cert_path = $cert_path
  }

  if ($merge_chain or $merge_key or $merge_dhparam) {
    concat { "${name}_cert_merged":
        ensure         => $ensure,
        ensure_newline => true,
        backup         => false,
        path           => "${_cert_path}/${cert}",
        owner          => $owner,
        group          => $group,
        mode           => $_cert_mode,
        require        => File[$cert_path],
        notify         => $service_notify,
    }

    concat::fragment { "${cert}_certificate":
      target  => "${name}_cert_merged",
      source  => $cert_source,
      content => $cert_content,
      order   => '01',
    }

    if ($merge_key) {
      concat::fragment { "${cert}_key":
        target  => "${name}_cert_merged",
        source  => $key_source,
        content => $key_content,
        order   => '02',
      }
    }

    if ($merge_chain) {
      if ($cert_chain) {
        concat::fragment { "${cert}_chain":
          target  => "${name}_cert_merged",
          source  => $chain_source,
          content => $chain_content,
          order   => '50',
        }
      }
      if ($ca_cert) {
        concat::fragment { "${cert}_ca":
          target  => "${name}_cert_merged",
          source  => $ca_source,
          content => $ca_content,
          order   => '90',
        }
      }
    }

    if ($dhparam and $merge_dhparam) {
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
    if $dhparam_dir {
      $dhparam_path = "${dhparam_dir}/${name}_${dhparam_file}"
    } else {
      $dhparam_path = "${cert_path}/${name}_${dhparam_file}"
    }

    ensure_resource('file', $dhparam_path, {
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
