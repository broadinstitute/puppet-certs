# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

* [`certs`](#certs): The certs class provides a single define, `certs::site`, configurable within Hiera as well.

### Defined types

* [`certs::site`](#certssite): Puppet module for SSL certificate installation.

## Classes

### <a name="certs"></a>`certs`

The certs class provides a single define, `certs::site`, configurable within Hiera as well.

#### Examples

##### Set some basic global options

```puppet
class { 'certs':
  cert_path => '/path/to/certs',
  key_path  => '/path/to/keys',
}
```

#### Parameters

The following parameters are available in the `certs` class:

* [`ca_cert`](#ca_cert)
* [`ca_content`](#ca_content)
* [`ca_ext`](#ca_ext)
* [`ca_name`](#ca_name)
* [`ca_path`](#ca_path)
* [`ca_source_path`](#ca_source_path)
* [`cert_chain`](#cert_chain)
* [`cert_content`](#cert_content)
* [`cert_dir_mode`](#cert_dir_mode)
* [`cert_ext`](#cert_ext)
* [`cert_mode`](#cert_mode)
* [`cert_path`](#cert_path)
* [`chain_content`](#chain_content)
* [`chain_ext`](#chain_ext)
* [`chain_name`](#chain_name)
* [`chain_path`](#chain_path)
* [`chain_source_path`](#chain_source_path)
* [`dhparam_file`](#dhparam_file)
* [`group`](#group)
* [`key_content`](#key_content)
* [`key_dir_mode`](#key_dir_mode)
* [`key_ext`](#key_ext)
* [`key_mode`](#key_mode)
* [`key_path`](#key_path)
* [`owner`](#owner)
* [`service`](#service)
* [`sites`](#sites)
* [`source_path`](#source_path)
* [`supported_os`](#supported_os)
* [`validate_x509`](#validate_x509)

##### <a name="ca_cert"></a>`ca_cert`

Data type: `Boolean`

Boolean for whether to look for a CA certificate file.
Optional value. (default: false).

Default value: ``false``

##### <a name="ca_content"></a>`ca_content`

Data type: `Optional[String]`

A string representing the contents of the CA file.
Optional value. (default: undef).

Default value: ``undef``

##### <a name="ca_ext"></a>`ca_ext`

Data type: `String`

The extension of the CA certificate file.
This sets the default globally for use by all `certs::site` resources.
Optional value. (default: 'crt').

Default value: `lookup('certs::cert_ext')`

##### <a name="ca_name"></a>`ca_name`

Data type: `Optional[String]`

The name of the CA certificate file.
Optional value. (default: undef).

Default value: ``undef``

##### <a name="ca_path"></a>`ca_path`

Data type: `Stdlib::Absolutepath`

Location where the CA certificate file will be stored on the managed node.
This sets the default globally for use by all `certs::site` resources.
Optional value. (default: `cert_path`).

Default value: `lookup('certs::cert_path')`

##### <a name="ca_source_path"></a>`ca_source_path`

Data type: `Optional[String]`

The location of the CA certificate file. Typically references a module's files.
e.g. `puppet:///ca_certs` will search for the mount point defined in the
fileserver.conf on the Puppet Server for the specified files.
Optional value. (default: `source_path`).

Default value: `$source_path`

##### <a name="cert_chain"></a>`cert_chain`

Data type: `Boolean`

Boolean for whether to look for a certificate chain file.
Optional value. (default: false).

Default value: ``false``

##### <a name="cert_content"></a>`cert_content`

Data type: `Optional[String]`

A string representing the contents of the certificate file.  This can only be
provided if `$source_path` is undefined or an error will occur.
Optional value. (default: undef).

Default value: ``undef``

##### <a name="cert_dir_mode"></a>`cert_dir_mode`

Data type: `String`

Permissions of the certificate directory.
This sets the default globally for use by all `certs::site` resources.
Optional value. (default: '0755').

##### <a name="cert_ext"></a>`cert_ext`

Data type: `String`

The extension of the certificate file.
This sets the default globally for use by all `certs::site` resources.
Optional value. (default: '.crt').

##### <a name="cert_mode"></a>`cert_mode`

Data type: `String`

Permissions of the certificate files.
This sets the default globally for use by all `certs::site` resources.
Optional value. (default: '0644').

##### <a name="cert_path"></a>`cert_path`

Data type: `Stdlib::Absolutepath`

Location where the certificate files will be stored on the managed node.
This sets the default globally for use by all `certs::site` resources.
Optional value. Defaults:
  - `/etc/pki/tls/certs` on RedHat-based systems
  - `/etc/ssl/certs` on Debian-based and Suse-based systems
  - `/usr/local/etc/apache24` on FreeBSD-based systems
  - `/etc/ssl/apache2` on Gentoo-based systems

##### <a name="chain_content"></a>`chain_content`

Data type: `Optional[String]`

A string representing the contents of the chain file.
Optional value. (default: undef).

Default value: ``undef``

##### <a name="chain_ext"></a>`chain_ext`

Data type: `String`

The extension of the certificate chain file.
This sets the default globally for use by all `certs::site` resources.
Optional value. (default: 'crt').

Default value: `lookup('certs::cert_ext')`

##### <a name="chain_name"></a>`chain_name`

Data type: `Optional[String]`

The name of the certificate chain file.
Optional value. (default: undef).

Default value: ``undef``

##### <a name="chain_path"></a>`chain_path`

Data type: `Stdlib::Absolutepath`

Location where the certificate chain file will be stored on the managed node.
This sets the default globally for use by all `certs::site` resources.
Optional value. (default: `$cert_path`).

Default value: `lookup('certs::cert_path')`

##### <a name="chain_source_path"></a>`chain_source_path`

Data type: `Optional[String]`

The location of the certificate chain file. Typically references a module's files.
e.g. `puppet:///chain_certs` will search for the mount point defined in the
fileserver.conf on the Puppet Server for the specified files.
Optional value. (default: `$source_path`).

Default value: `$source_path`

##### <a name="dhparam_file"></a>`dhparam_file`

Data type: `String`

The name of the dhparam file.
This sets the default globally for use by all `certs::site` resources.
Optional value. (default: 'dh2048.pem').

##### <a name="group"></a>`group`

Data type: `String`

Name of the group owner of the certificates.
This sets the default globally for use by all `certs::site` resources.
Optional value. Defaults:
  - `root` for Redhat-based, Debian-based, and Suse-based systems
  - `wheel` for FreeBSD and Gentoo-based systems

##### <a name="key_content"></a>`key_content`

Data type: `Optional[String]`

A string representing the contents of the key file.  This can only be
provided if `$source_path` is undefined or an error will occur.
Optional value. (default: undef).

Default value: ``undef``

##### <a name="key_dir_mode"></a>`key_dir_mode`

Data type: `String`

Permissions of the private keys directory.
This sets the default globally for use by all `certs::site` resources.
Optional value. (default: '0755').

##### <a name="key_ext"></a>`key_ext`

Data type: `String`

The extension of the private key file.
This sets the default globally for use by all `certs::site` resources.
Optional value. (default: '.key').

##### <a name="key_mode"></a>`key_mode`

Data type: `String`

Permissions of the private keys.
This sets the default globally for use by all `certs::site` resources.
Optional value. (default: '0600').

##### <a name="key_path"></a>`key_path`

Data type: `Stdlib::Absolutepath`

Location where the private keys will be stored on the managed node.
This sets the default globally for use by all `certs::site` resources.
Optional value. Defaults:
  - `/etc/pki/tls/private` on RedHat-based systems
  - `/etc/ssl/private` on Debian-based and Suse-based systems
  - `/usr/local/etc/apache24` on FreeBSD-based systems
  - `/etc/ssl/apache2` on Gentoo-based systems

##### <a name="owner"></a>`owner`

Data type: `String`

Name of the owner of the certificates.
This sets the default globally for use by all `certs::site` resources.
Optional value. (default: 'root').

##### <a name="service"></a>`service`

Data type: `Optional[Variant[Array[String],Boolean,String]]`

Name of the server service(s) to notify when certificates are updated.
Setting to false (or any Boolean) will disable service notifications.
This sets the default globally for use by all `certs::site` resources.
Optional value. Defaults:
  - `httpd` for RedHat-based systems
  - `apache2` for Debian-based, Suse-based, and Gentoo-based systems
  - `apache24` for FreeBSD-based systems

Default value: `lookup('certs::service')`

##### <a name="sites"></a>`sites`

Data type: `Hash`

A hash of `certs::site` configurations, typically provided by Hiera.
Optional value: (default: {}).

Default value: `{}`

##### <a name="source_path"></a>`source_path`

Data type: `Optional[String]`

The location of the certificate files. Typically references a module's files.
e.g. `puppet:///site_certs` will search for the mount point defined in the
fileserver.conf on the Puppet Server for the specified files.

Default value: ``undef``

##### <a name="supported_os"></a>`supported_os`

Data type: `Boolean`

A boolean value for whether or not the running OS is supported by the module.
Configured by default data.

Default value: ``false``

##### <a name="validate_x509"></a>`validate_x509`

Data type: `Boolean`

A boolean value to determine whether or not to validate the certificate and key pairs.
Failure will cause the catalog to fail compilation.
Optional value. (default: false).

Default value: ``false``

## Defined types

### <a name="certssite"></a>`certs::site`

Can be used in conjunction with puppetlabs/apache's apache::vhost
definitions, to provide the ssl_cert and ssl_key files, or any
other service requiring SSL certificates. It can also be used
independent of any Puppet-defined service.

#### Examples

##### Without Hiera

```puppet
include certs
$cname = 'www.example.com'
certs::site { $cname:
  ca_cert        => true,
  ca_name        => 'caname',
  ca_source_path => 'puppet:///ca_certs',
  source_path    => 'puppet:///site_certificates',
}
```

##### With Hiera

```puppet
---
classes:
  - certs
certs::sites:
  'www.example.com':
    ca_cert: true
    ca_name: 'caname'
    ca_source_path: 'puppet:///ca_certs'
    source_path: 'puppet:///site_certificates'
```

##### Resource Chaining with Apache Module

```puppet
Certs::Site<| |> -> Apache::Vhost<| |>
```

#### Parameters

The following parameters are available in the `certs::site` defined type:

* [`ca_cert`](#ca_cert)
* [`ca_content`](#ca_content)
* [`ca_ext`](#ca_ext)
* [`ca_name`](#ca_name)
* [`ca_path`](#ca_path)
* [`ca_source_path`](#ca_source_path)
* [`cert_chain`](#cert_chain)
* [`cert_content`](#cert_content)
* [`cert_dir_mode`](#cert_dir_mode)
* [`cert_ext`](#cert_ext)
* [`cert_mode`](#cert_mode)
* [`cert_path`](#cert_path)
* [`chain_content`](#chain_content)
* [`chain_ext`](#chain_ext)
* [`chain_name`](#chain_name)
* [`chain_path`](#chain_path)
* [`chain_source_path`](#chain_source_path)
* [`dhparam`](#dhparam)
* [`dhparam_content`](#dhparam_content)
* [`dhparam_dir`](#dhparam_dir)
* [`dhparam_file`](#dhparam_file)
* [`ensure`](#ensure)
* [`group`](#group)
* [`key_content`](#key_content)
* [`key_dir_mode`](#key_dir_mode)
* [`key_ext`](#key_ext)
* [`key_mode`](#key_mode)
* [`key_path`](#key_path)
* [`merge_chain`](#merge_chain)
* [`merge_dhparam`](#merge_dhparam)
* [`merge_key`](#merge_key)
* [`owner`](#owner)
* [`service`](#service)
* [`source_cert_name`](#source_cert_name)
* [`source_key_name`](#source_key_name)
* [`source_path`](#source_path)
* [`validate_x509`](#validate_x509)

##### <a name="ca_cert"></a>`ca_cert`

Data type: `Boolean`

Boolean for whether to look for a CA certificate file.
Optional value. (default: false).

Default value: `$::certs::ca_cert`

##### <a name="ca_content"></a>`ca_content`

Data type: `Optional[String]`

A string representing the contents of the CA file.
Optional value. (default: undef).

Default value: `$::certs::ca_content`

##### <a name="ca_ext"></a>`ca_ext`

Data type: `String`

The extension of the CA certificate file.
Optional value. (default: 'crt').

Default value: `$::certs::ca_ext`

##### <a name="ca_name"></a>`ca_name`

Data type: `Optional[String]`

The name of the CA certificate file.
Optional value. (default: undef).

Default value: `$::certs::ca_name`

##### <a name="ca_path"></a>`ca_path`

Data type: `Stdlib::Absolutepath`

Location where the CA certificate file will be stored on the managed node.
Optional value. (default: `cert_path`).

Default value: `$::certs::ca_path`

##### <a name="ca_source_path"></a>`ca_source_path`

Data type: `Optional[String]`

The location of the CA certificate file. Typically references a module's files.
e.g. `puppet:///ca_certs` will search for the mount point defined in the
fileserver.conf on the Puppet Server for the specified files.
Optional value. (default: `source_path`).

Default value: `pick_default($::certs::ca_source_path, $source_path)`

##### <a name="cert_chain"></a>`cert_chain`

Data type: `Boolean`

Boolean for whether to look for a certificate chain file.
Optional value. (default: false).

Default value: `$::certs::cert_chain`

##### <a name="cert_content"></a>`cert_content`

Data type: `Optional[String]`

A string representing the contents of the certificate file.  This can only be
provided if `$source_path` is undefined or an error will occur.
Optional value. (default: undef).

Default value: `$::certs::cert_content`

##### <a name="cert_dir_mode"></a>`cert_dir_mode`

Data type: `String`

Permissions of the certificate directory.
Optional value. (default: '0755').

Default value: `$::certs::cert_dir_mode`

##### <a name="cert_ext"></a>`cert_ext`

Data type: `String`

The extension of the certificate file.
Optional value. (default: '.crt').

Default value: `$::certs::cert_ext`

##### <a name="cert_mode"></a>`cert_mode`

Data type: `String`

Permissions of the certificate files.
Optional value. (default: '0644').

Default value: `$::certs::cert_mode`

##### <a name="cert_path"></a>`cert_path`

Data type: `Stdlib::Absolutepath`

Location where the certificate files will be stored on the managed node.
Optional value. Defaults:
  - `/etc/pki/tls/certs` on RedHat-based systems
  - `/etc/ssl/certs` on Debian-based and Suse-based systems
  - `/usr/local/etc/apache24` on FreeBSD-based systems
  - `/etc/ssl/apache2` on Gentoo-based systems

Default value: `$::certs::cert_path`

##### <a name="chain_content"></a>`chain_content`

Data type: `Optional[String]`

A string representing the contents of the chain file.
Optional value. (default: undef).

Default value: `$::certs::chain_content`

##### <a name="chain_ext"></a>`chain_ext`

Data type: `String`

The extension of the certificate chain file.
Optional value. (default: 'crt').

Default value: `$::certs::chain_ext`

##### <a name="chain_name"></a>`chain_name`

Data type: `Optional[String]`

The name of the certificate chain file.
Optional value. (default: undef).

Default value: `$::certs::chain_name`

##### <a name="chain_path"></a>`chain_path`

Data type: `Stdlib::Absolutepath`

Location where the certificate chain file will be stored on the managed node.
Optional value. (default: `$cert_path`).

Default value: `$::certs::chain_path`

##### <a name="chain_source_path"></a>`chain_source_path`

Data type: `Optional[String]`

The location of the certificate chain file. Typically references a module's files.
e.g. `puppet:///chain_certs` will search for the mount point defined in the
fileserver.conf on the Puppet Server for the specified files.
Optional value. (default: `$source_path`).

Default value: `pick_default($::certs::chain_source_path, $source_path)`

##### <a name="dhparam"></a>`dhparam`

Data type: `Boolean`

A boolean value to determine whether a dhparam file should be placed on the
system along with the other certificate files.  The dhparam file will need to
exist on the source side just as with the other certificate files in order
for the file to be delivered.
Optional value. (default: false).

Default value: ``false``

##### <a name="dhparam_content"></a>`dhparam_content`

Data type: `Optional[String]`

A string representing the contents of the dhparam file.  This option will
take precedence over dhparam_file if it exists on the source side.
Optional value. (default: undef).

Default value: ``undef``

##### <a name="dhparam_dir"></a>`dhparam_dir`

Data type: `Optional[Stdlib::Absolutepath]`

The directory in which the dhparam file should be placed.
Optional value. (default: `$cert_path`).

Default value: ``undef``

##### <a name="dhparam_file"></a>`dhparam_file`

Data type: `String`

The name of the dhparam file.
Optional value. (default: 'dh2048.pem').

Default value: `$::certs::dhparam_file`

##### <a name="ensure"></a>`ensure`

Data type: `Enum['present','absent']`

Ensure for the site resources.  If 'present', files will be put in place.  If
'absent', files will be removed.
Optional value. (default: 'present').

Default value: `'present'`

##### <a name="group"></a>`group`

Data type: `String`

Name of the group owner of the certificates.
Optional value. Defaults:
  - `root` for Redhat-based, Debian-based, and Suse-based systems
  - `wheel` for FreeBSD and Gentoo-based systems

Default value: `$::certs::group`

##### <a name="key_content"></a>`key_content`

Data type: `Optional[String]`

A string representing the contents of the key file.  This can only be
provided if `$source_path` is undefined or an error will occur.
Optional value. (default: undef).

Default value: `$::certs::key_content`

##### <a name="key_dir_mode"></a>`key_dir_mode`

Data type: `String`

Permissions of the private keys directory.
Optional value. (default: '0755').

Default value: `$::certs::key_dir_mode`

##### <a name="key_ext"></a>`key_ext`

Data type: `String`

The extension of the private key file.
Optional value. (default: '.key').

Default value: `$::certs::key_ext`

##### <a name="key_mode"></a>`key_mode`

Data type: `String`

Permissions of the private keys.
Optional value. (default: '0600').

Default value: `$::certs::key_mode`

##### <a name="key_path"></a>`key_path`

Data type: `Stdlib::Absolutepath`

Location where the private keys will be stored on the managed node.
Optional value. Defaults:
  - `/etc/pki/tls/private` on RedHat-based systems
  - `/etc/ssl/private` on Debian-based and Suse-based systems
  - `/usr/local/etc/apache24` on FreeBSD-based systems
  - `/etc/ssl/apache2` on Gentoo-based systems

Default value: `$::certs::key_path`

##### <a name="merge_chain"></a>`merge_chain`

Data type: `Boolean`

Option to merge the CA and chain files into the actual certificate file,
which is required by some software.
Optional value. (default: false).

Default value: ``false``

##### <a name="merge_dhparam"></a>`merge_dhparam`

Data type: `Boolean`

Option to merge the DH paramaters file into the actual certificate file,
which is required by some software.
Optional value. (default: false).

Default value: ``false``

##### <a name="merge_key"></a>`merge_key`

Data type: `Boolean`

Option to merge the private into the actual certificate file, which is
required by some software.
Optional value. (default: false).

Default value: ``false``

##### <a name="owner"></a>`owner`

Data type: `String`

Name of the owner of the certificates.
Optional value. (default: 'root').

Default value: `$::certs::owner`

##### <a name="service"></a>`service`

Data type: `Optional[Variant[Array[String],Boolean,String]]`

Name of the server service(s) to notify when certificates are updated.
Setting to false (or any Boolean) will disable service notifications.
Optional value. Defaults:
  - `httpd` for RedHat-based systems
  - `apache2` for Debian-based, Suse-based, and Gentoo-based systems
  - `apache24` for FreeBSD-based systems

Default value: `$::certs::service`

##### <a name="source_cert_name"></a>`source_cert_name`

Data type: `Optional[String]`

The name of the source certificate file.
Optional value. (default: `$namevar`).

Default value: ``undef``

##### <a name="source_key_name"></a>`source_key_name`

Data type: `Optional[String]`

The name of the source key file.
Optional value. (default: `$namevar`).

Default value: ``undef``

##### <a name="source_path"></a>`source_path`

Data type: `Optional[String]`

The location of the certificate files. Typically references a module's files.
e.g. `puppet:///site_certs` will search for the mount point defined in the
fileserver.conf on the Puppet Server for the specified files.

Default value: `$::certs::source_path`

##### <a name="validate_x509"></a>`validate_x509`

Data type: `Boolean`

A boolean value to determine whether or not to validate the certificate and key pairs.
Failure will cause the catalog to fail compilation.
Optional value. (default: false).

Default value: `$::certs::validate_x509`
