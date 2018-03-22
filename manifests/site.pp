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
# [ca_cert]
# Boolean for whether to look for a CA certificate file.
# Optional value. Default: false.
#
# [ca_content]
# A string representing the contents of the CA file.
# Optional value. Default: undef.
#
# [ca_ext]
# The extension of the CA certificate file.
# Optional value. Default: crt.
#
# [ca_name]
# The name of the CA certificate file.
# Optional value. Default: undef.
#
# [ca_path]
# Location where the CA certificate file will be stored on the managed node.
# Optional value. Default: [cert_path].
#
# [ca_source_path]
# The location of the CA certificate file. Typically references a module's files.
# e.g. 'puppet:///ca_certs' will search for the mount point defined in the
# fileserver.conf on the Puppet Server for the specified files.
# Optional value. Default: [source_path].
#
# [cert_chain]
# Boolean for whether to look for a certificate chain file.
# Optional value. Default: false.
#
# [cert_content]
# A string representing the contents of the certificate file.  This can only be
# provided if $source_path is undefined or an error will occur.
# Optional value. Default: undef.
#
# [cert_dir_mode]
# Permissions of the certificate directory.
# Optional value. Default: '0755'.
#
# [cert_ext]
# The extension of the certificate file.
# Optional value. Default: '.crt'.
#
# [cert_mode]
# Permissions of the certificate files.
# Optional value. Default: '0644'.
#
# [cert_path]
# Location where the certificate files will be stored on the managed node.
# Optional value. Defaults:
#   - '/etc/pki/tls/certs' on RedHat-based systems
#   - '/etc/ssl/certs' on Debian-based and Suse-based systems
#   - '/usr/local/etc/apache24' on FreeBSD-based systems
#   - '/etc/ssl/apache2' on Gentoo-based systems
#
# [chain_content]
# A string representing the contents of the chain file.
# Optional value. Default: undef.
#
# [chain_ext]
# The extension of the certificate chain file.
# Optional value. Default: crt.
#
# [chain_name]
# The name of the certificate chain file.
# Optional value. Default: undef.
#
# [chain_path]
# Location where the certificate chain file will be stored on the managed node.
# Optional value. Default: [cert_path].
#
# [chain_source_path]
# The location of the certificate chain file. Typically references a module's files.
# e.g. 'puppet:///chain_certs' will search for the mount point defined in the
# fileserver.conf on the Puppet Server for the specified files.
# Optional value. Default: [source_path].
#
# [dhparam]
# A boolean value to determine whether a dhparam file should be placed on the
# system along with the other certificate files.  The dhparam file will need to
# exist on the source side just as with the other certificate files in order
# for the file to be delivered.
# Optional value. Default: false
#
# [dhparam_content]
# A string representing the contents of the dhparam file.  This option will
# take precedence over dhparam_file if it exists on the source side.
# Optional value. Default: undef.
#
# [dhparam_file]
# The name of the dhparam file.
# Optional value. Default: 'dh2048.pem'.
#
# [ensure]
# Ensure for the site resources.  If 'present', files will be put in place.  If
# 'absent', files will be removed.
# Optional value. Default: 'present'
#
# [group]
# Name of the group owner of the certificates.
# Optional value. Defaults:
#   - 'root' for Redhat-based, Debian-based, and Suse-based systems
#   - 'wheel' for FreeBSD and Gentoo-based systems
#
# [key_content]
# A string representing the contents of the key file.  This can only be
# provided if $source_path is undefined or an error will occur.
# Optional value. Default: undef.
#
# [key_dir_mode]
# Permissions of the private keys directory.
# Optional value. Default: '0755'.
#
# [key_ext]
# The extension of the private key file.
# Optional value. Default: '.key'.
#
# [key_mode]
# Permissions of the private keys.
# Optional value. Default: '0600'.
#
# [key_path]
# Location where the private keys will be stored on the managed node.
# Optional value. Defaults:
#   - '/etc/pki/tls/private' on RedHat-based systems
#   - '/etc/ssl/private' on Debian-based and Suse-based systems
#   - '/usr/local/etc/apache24' on FreeBSD-based systems
#   - '/etc/ssl/apache2' on Gentoo-based systems
#
# [merge_chain]
# Option to merge the CA and chain files into the actual certificate file,
# which is required by some software.
# Optional value. Default: false.
#
# [merge_dhparam]
# Option to merge the DH paramaters file into the actual certificate file,
# which is required by some software.
# Optional value. Default: false.
#
# [merge_key]
# Option to merge the private into the actual certificate file, which is
# required by some software.
# Optional value. Default: false.
#
# [owner]
# Name of the owner of the certificates.
# Optional value. Default: 'root'.
#
# [service]
# Name of the server service to notify when certificates are updated.
# Setting to `undef` will disable service notifications.
# Optional value. Defaults:
#   - 'httpd' for RedHat-based systems
#   - 'apache2' for Debian-based, Suse-based, and Gentoo-based systems
#   - 'apache24' for FreeBSD-based systems
#
# [source_path]
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
# Copyright 2016
#
define certs::site(
    $ca_cert           = false,
    $ca_content        = undef,
    $ca_ext            = undef,
    $ca_name           = undef,
    $ca_path           = undef,
    $ca_source_path    = undef,
    $cert_chain        = false,
    $cert_content      = undef,
    $cert_dir_mode     = undef,
    $cert_ext          = undef,
    $cert_mode         = undef,
    $cert_path         = undef,
    $chain_content     = undef,
    $chain_ext         = undef,
    $chain_name        = undef,
    $chain_path        = undef,
    $chain_source_path = undef,
    $dhparam           = false,
    $dhparam_content   = undef,
    $dhparam_file      = undef,
    $ensure            = 'present',
    $group             = undef,
    $key_content       = undef,
    $key_dir_mode      = undef,
    $key_ext           = undef,
    $key_mode          = undef,
    $key_path          = undef,
    $owner             = undef,
    $merge_chain       = false,
    $merge_dhparam     = false,
    $merge_key         = false,
    $service           = undef,
    $source_path       = undef,
) {

  # The base class must be included first because it is used by parameter defaults
    if ! defined(Class['certs']) {
        fail('You must include the certs base class before using any certs defined resources')
    }

    if ($name == undef) {
        fail('You must provide a name value for the site to certs::site.')
    }
    if ($source_path == undef and ($cert_content == undef or $key_content == undef)) {
        fail('You must provide a source_path or cert_content/key_content combination for the SSL files to certs::site.')
    }

    if ($source_path and ($cert_content or $key_content)) {
        fail('You can only provide $source_path or $cert_content/$key_content, not both.')
    }

    if !$source_path {
        if !($cert_content and $key_content) {
            fail('If source_path is not set, $cert_content and $key_content must both be set.')
        }
    }

    $_ca_ext        = pick_default($ca_ext, $::certs::_ca_ext)
    $_ca_path       = pick_default($ca_path, $::certs::_ca_path)
    $_cert_dir_mode = pick_default($cert_dir_mode, $::certs::_cert_dir_mode)
    $_cert_ext      = pick_default($cert_ext, $::certs::_cert_ext)
    $_cert_mode     = pick_default($cert_mode, $::certs::_cert_mode)
    $_cert_path     = pick_default($cert_path, $::certs::_cert_path)
    $_chain_ext     = pick_default($chain_ext, $::certs::_chain_ext)
    $_chain_path    = pick_default($chain_path, $::certs::_chain_path)
    $_dhparam_file  = pick_default($dhparam_file, $::certs::_dhparam_file)
    $_group         = pick_default($group, $::certs::_group)
    $_key_dir_mode  = pick_default($key_dir_mode, $::certs::_key_dir_mode)
    $_key_ext       = pick_default($key_ext, $::certs::_key_ext)
    $_key_mode      = pick_default($key_mode, $::certs::_key_mode)
    $_key_path      = pick_default($key_path, $::certs::_key_path)
    $_owner         = pick_default($owner, $::certs::_owner)
    $_service       = pick_default($service, $::certs::_service)

    if $ca_source_path {
        $_ca_source_path = $ca_source_path
    } else {
        $_ca_source_path = $source_path
    }

    if $chain_source_path {
        $_chain_source_path = $chain_source_path
    } else {
        $_chain_source_path = $source_path
    }

    if $dhparam_content {
        $dhparam_source = undef
    } else {
        $dhparam_source = "${source_path}/${_dhparam_file}"
    }

    validate_bool($ca_cert)
    validate_string($_ca_ext)
    validate_absolute_path($_ca_path)
    validate_bool($cert_chain)
    validate_string($_cert_dir_mode)
    validate_numeric($_cert_dir_mode)
    validate_string($_cert_ext)
    validate_string($_cert_mode)
    validate_numeric($_cert_mode)
    validate_absolute_path($_cert_path)
    validate_string($_chain_ext)
    validate_absolute_path($_chain_path)
    validate_bool($dhparam)
    validate_re($ensure, '^(present|absent)$')
    validate_string($_group)
    validate_string($_key_dir_mode)
    validate_numeric($_key_dir_mode)
    validate_string($_key_ext)
    validate_string($_key_mode)
    validate_numeric($_key_mode)
    validate_absolute_path($_key_path)
    validate_bool($merge_chain)
    validate_bool($merge_dhparam)
    validate_bool($merge_key)
    validate_string($_owner)

    if $service != undef {
        validate_string($service)
    }

    if $cert_chain {
        if ($chain_name == undef) {
            fail('You must provide a chain_name value for the cert chain to certs::site.')
        }
        $chain = "${chain_name}${_chain_ext}"

        if $chain_content == undef {
            if ($_chain_source_path == undef) {
                fail('You must provide a chain_source_path for the SSL files to certs::site.')
            }

            $chain_source = "${_chain_source_path}/${chain}"
        } else {
            $chain_source = undef
        }
    }

    if $ca_cert {
        if ($ca_name == undef) {
            fail('You must provide a ca_name value for the CA cert to certs::site.')
        }
        $ca = "${ca_name}${_ca_ext}"

        if $ca_content == undef {
            if ($_ca_source_path == undef) {
                fail('You must provide a ca_source_path for the SSL files to certs::site.')
            }

            $ca_source = "${_ca_source_path}/${ca}"
        } else {
            $ca_source = undef
        }
    }

    $cert = "${name}${_cert_ext}"
    $key  = "${name}${_key_ext}"

    if $service != undef {
        if defined(Service[$service]) {
            $service_notify = Service[$service]
        } else {
            $service_notify = undef
        }
    } else {
        $service_notify = undef
    }
    if ($_ca_path =~ /etc\/pki\/ca-trust/) {
        $exec_notify = Exec['update_ca_trust']
    } else {
        $exec_notify = undef
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

    if $source_path == undef {
        $cert_source = undef
        $key_source = undef
    } else {
        $cert_source = "${source_path}/${cert}"
        $key_source = "${source_path}/${key}"
    }

    if $merge_chain or $merge_key or $merge_dhparam {
        concat { "${name}_cert_merged":
            ensure         => $ensure,
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
            target  => "${name}_cert_merged",
            source  => $cert_source,
            content => $cert_content,
            order   => '01'
        }

        if $merge_key {
            concat::fragment { "${cert}_key":
                target  => "${name}_cert_merged",
                source  => $key_source,
                content => $key_content,
                order   => '02'
            }
        }

        if $merge_chain {
            if $cert_chain {
                concat::fragment { "${cert}_chain":
                    target  => "${name}_cert_merged",
                    source  => $chain_source,
                    content => $chain_content,
                    order   => '50'
                }
            }
            if $ca_cert {
                concat::fragment { "${cert}_ca":
                    target  => "${name}_cert_merged",
                    source  => $ca_source,
                    content => $ca_content,
                    order   => '90'
                }
            }
        }

        if $dhparam and $merge_dhparam {
            concat::fragment { "${cert}_dhparam":
                target  => "${name}_cert_merged",
                source  => $dhparam_source,
                content => $dhparam_content,
                order   => '95'
            }
        }
    } else {
        file { "${_cert_path}/${cert}":
            ensure  => $ensure,
            source  => $cert_source,
            content => $cert_content,
            owner   => $_owner,
            group   => $_group,
            mode    => $_cert_mode,
            require => File[$_cert_path],
            notify  => $service_notify,
        }
    }

    file { "${_key_path}/${key}":
        ensure  => $ensure,
        source  => $key_source,
        content => $key_content,
        owner   => $_owner,
        group   => $_group,
        mode    => $_key_mode,
        require => File[$_key_path],
        notify  => $service_notify,
    }

    if ($cert_chain and !defined(File["${_chain_path}/${chain}"])) {
        file { "${_chain_path}/${chain}":
            ensure  => 'file',
            source  => $chain_source,
            content => $chain_content,
            owner   => $_owner,
            group   => $_group,
            mode    => $_cert_mode,
            require => File[$_chain_path],
            notify  => $service_notify,
        }
    }

    if ($ca_cert and !defined(File["${_ca_path}/${ca}"])) {
        file { "${_ca_path}/${ca}":
            ensure  => 'file',
            source  => $ca_source,
            content => $ca_content,
            owner   => $_owner,
            group   => $_group,
            mode    => $_cert_mode,
            require => File[$_ca_path],
            notify  => [$service_notify,$exec_notify],
        }
    }

    if ($dhparam and !defined(File["${_cert_path}/${name}_${_dhparam_file}"])) {
        file { "${_cert_path}/${name}_${_dhparam_file}":
            ensure  => $ensure,
            source  => $dhparam_source,
            content => $dhparam_content,
            owner   => $_owner,
            group   => $_group,
            mode    => $_cert_mode,
            require => File[$_cert_path],
            notify  => $service_notify,
        }
    }
}
