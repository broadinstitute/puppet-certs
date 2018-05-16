# certs
[![Build Status](https://travis-ci.org/broadinstitute/puppet-certs.svg?branch=master)](https://travis-ci.org/broadinstitute/puppet-certs)
[![Puppet Forge](https://img.shields.io/puppetforge/dt/broadinstitute/certs.svg)](https://forge.puppetlabs.com/broadinstitute/certs)
[![Puppet Forge](https://img.shields.io/puppetforge/v/broadinstitute/certs.svg)](https://forge.puppetlabs.com/broadinstitute/certs)
[![Puppet Forge](https://img.shields.io/puppetforge/f/broadinstitute/certs.svg)](https://forge.puppetlabs.com/broadinstitute/certs)
[![License (Apache 2.0)](https://img.shields.io/badge/license-Apache-blue.svg)](https://opensource.org/licenses/Apache-2.0)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [Setup requirements](#setup-requirements)
4. [Usage](#usage)
    * [Installation](#installation)
    * [Examples](#examples)
5. [Reference](#reference)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Contributors](#contributors)

## Overview
Configures SSL certificates and keys.

## Module Description

This module provides SSL certificate files required by Apache or other services via the certs::site define.
It can be used in conjunction with puppetlabs/apache's apache::vhost definitions to provide the ssl_cert and ssl_key files or any other service requiring SSL certificates.

It can also be used independent of any Puppet-defined service that requires the files to exist on a managed node.

## Setup

### Setup Requirements

The certificate files must come from an external store. Recommended stores are a site-specific (and private) module containing SSL files or a network-accessible filesystem, such as NFS, that the managed node can access.
Once a file store is determined, include at least one certs::site define and specify the file store location as the `source_path`.

By default, this module will place certificates and keys in their relative locations and restart the specified service, provided it is defined in the catalog.
- **RedHat**
 * certificates directory: `/etc/pki/tls/certs`
 * keys directory: `/etc/pki/tls/private`
 * service: `httpd`

- **Debian & Suse**
 * certificates directory: `/etc/ssl/certs`
 * keys directory: `/etc/ssl/private`
 * service: `apache2`

- **FreeBSD**
 * certificates directory: `/usr/local/etc/apache24`
 * keys directory: `/usr/local/etc/apache24`
 * service: `apache24`

- **Gentoo**
 * certificates directory: `/etc/ssl/apache2`
 * keys directory: `/etc/ssl/apache2`
 * service: `apache2`

## Usage

No trailing slashes should be provided for any paths.

Installation
------------

**Puppet Forge:**

``` sh
puppet module install broadinstitute-certs
```

**Puppetfile:**

``` sh
mod 'broadinstitute/certs'
```

Examples
--------

**Puppet Manifest:**

    manifest.pp
    -----------
~~~
  include certs
  $domain = 'www.example.com'
  certs::site { $domain:
    source_path    => 'puppet:///site_certificates',
    ca_cert        => true,
    ca_name        => 'caname',
    ca_source_path => 'puppet:///ca_certs',
  }
~~~

**With Hiera:**

    node.yaml
    ---------
~~~
  classes:
    - certs
  certs::sites:
    'www.example.com':
      source_path: 'puppet:///site_certificates'
      ca_cert: true
      ca_name: 'caname'
      ca_source_path: 'puppet:///ca_certs'
~~~

**Resource Chaining with Apache Module:**

    manifest.pp
    -----------
~~~
  Certs::Site<| |> -> Apache::Vhost<| |>
~~~

**Global Defaults:**

You can also reset some of the settings in params.pp globally via the **certs** base class which will be inherited by all **certs::site** defines used that are later defined.  In this example, we can reset the default certificate and key paths for all instantiated sites so that we don't have to manually set the custom path in each site:

~~~
  $domain1 = 'www.example.com'
  $domain2 = 'foo.example.com'

  class { 'certs':
    cert_path => '/path/to/certs',
    key_path  => '/path/to/keys',
  }

  certs::site { $domain1:
    source_path    => 'puppet:///site_certificates',
    ca_cert        => true,
    ca_name        => 'caname',
    ca_source_path => 'puppet:///ca_certs',
  }

  certs::site { $domain2:
    source_path    => 'puppet:///site_certificates',
    ca_cert        => true,
    ca_name        => 'caname',
    ca_source_path => 'puppet:///ca_certs',
  }
~~~

## Reference

- [**Public classes**](#public-classes)
  - [Class: certs](#class-certs)
- [**Private classes**](#private-classes)
  - [Class: certs::params](#class-certsparams)
- [**Public defined types**](#public-defined-types)
  - [Defined type: certs::site](#defined-type-certssite)
  - [Parameters within certs::site](#parameters-within-certssite)

### Public Classes

#### Class: `certs`

Instantiates the availability of the certs::site defined type.

You can simply declare the default `certs` class:

``` puppet
class { 'certs': }
```

### Private Classes

#### Class: `certs::params`

Manages parameters for configuring certificate sites.

### Public Defined Types

#### Defined type: `certs::site`

The Certs module allows a lot of flexibility in the configuration of sites. This flexibility is due, in part, to `site` being a defined resource type, which allows it to be evaluated multiple times with different parameters.

The `certs::site` defined type allows you to define certificates to deploy to managed nodes and restart dependent services automatically.

#### Parameters within `certs::site`

##### `ca_cert`
Boolean for whether to look for a CA certificate file.

Optional value. **Default: false**.

##### `ca_content`
A string representing the contents of the CA file.

Optional value. **Default: undef**.

##### `ca_ext`
The extension of the CA certificate file.

Optional value. **Default: crt**.

##### `ca_name`
The name of the CA certificate file.

Optional value. **Default: undef**.

##### `ca_path`
Location where the CA certificate file will be stored on the managed node.

Optional value. **Default: `cert_path`**.

##### `ca_source_path`
The location of the CA certificate file. Typically references a module's files.

e.g. *'puppet:///ca_certs'* will search for the mount point defined in `fileserver.conf` on the Puppet Server for the specified files.

Optional value. **Default: `source_path`**.

##### `cert_chain`
Boolean for whether to look for a certificate chain file.

Optional value. **Default: false**.

##### `cert_content`
A string representing the contents of the certificate file.  This can only be provided if `$source_path` is undefined or an error will occur.

Optional value. **Default: undef**.

##### `cert_dir_mode`
Permissions of the certificate directory.

Optional value. **Default: '0755'**.

##### `cert_ext`
The extension of the certificate file.

Optional value. **Default: '.crt'**.

##### `cert_mode`
Permissions of the certificate files.

Optional value. **Default: '0644'**.

##### `cert_path`
Location where the certificate files will be stored on the managed node.

Optional value. Defaults:
  - **RedHat**: `/etc/pki/tls/certs`
  - **Debian** and **SuSE**: `/etc/ssl/certs`
  - **FreeBSD**: `/usr/local/etc/apache24`
  - **Gentoo**: `/etc/ssl/apache2`

##### `chain_content`
A string representing the contents of the chain file.

Optional value. Default: **undef**.

##### `chain_ext`
The extension of the certificate chain file.

Optional value. **Default: crt**.

##### `chain_name`
The name of the certificate chain file.

Optional value. **Default: undef**.

##### `chain_path`
Location where the certificate chain file will be stored on the managed node.

Optional value. **Default: `cert_path`**.

##### `chain_source_path`
The location of the certificate chain file. Typically references a module's files.

e.g. *'puppet:///chain_certs'* will search for the mount point defined in `fileserver.conf` on the Puppet Server for the specified files.

Optional value. **Default: `source_path`**.

##### `dhparam`
A boolean value to determine whether a dhparam file should be placed on the system along with the other certificate files.  The dhparam file will need to exist on the source side just as with the other certificate files in order for the file to be delivered.

Optional value. **Default: false**.

##### `dhparam_content`
A string representing the contents of the dhparam file.  This option will take precedence over dhparam_file if it exists on the source side.

Optional value. **Default: undef**.

##### `dhparam_file`
The name of the dhparam file.

Optional value. **Default: 'dh2048.pem'**.

##### `ensure`
Ensure for the site resources.  If `present`, files will be put in place.  If `absent`, certificate, key and dhparam files will be removed.

Optional value. **Default: 'present'**.

##### `group`
Name of the group owner of the certificates.

Optional value. Defaults:
  - **RedHat**, **Debian**, and **SuSE**: `root`
  - **FreeBSD** and **Gentoo**: `wheel`

##### `key_content`
A string representing the contents of the key file.  This can only be provided if `$source_path` is undefined or an error will occur.

Optional value. **Default: undef**.

##### `key_dir_mode`
Permissions of the private keys directory.

Optional value. **Default: '0755'**.

##### `key_ext`
The extension of the private key file.

Optional value. **Default: '.key'**.

##### `key_mode`
Permissions of the private keys.

Optional value. **Default: '0600'**.

##### `key_path`
Location where the private keys will be stored on the managed node.

Optional value. Defaults:
  - **RedHat**: `/etc/pki/tls/private`
  - **Debian** and **SuSE**: `/etc/ssl/private`
  - **FreeBSD**: `/usr/local/etc/apache24`
  - **Gentoo**: `/etc/ssl/apache2`

##### `merge_chain`
Option to merge the CA and intermediate chain files into the actual certificate file, which is required by some software.

Optional value. **Default: false**.

##### `merge_dhparam`
Option to merge the DH paramaters file into the actual certificate file, which is required by some software.

Optional value. **Default: false**.

##### `merge_key`
Option to merge the private key into the actual certificate file, which is required by some software.

Optional value. **Default: false**.

##### `name`
The title of the resource matches the certificate's name

e.g. **www.example.com** matches the certificate for the hostname **www.example.com**.

##### `owner`
Name of the owner of the certificates.

Optional value. **Default: 'root'**.

##### `service`
Name of the server service to notify when certificates are updated.

Setting to `undef` will disable service notifications.

Optional value. Defaults:
   - **RedHat**: `httpd`
   - **Debian**, **SuSE**, and **Gentoo**: `apache2`
   - **FreeBSD**: `apache24`

##### `source_path`
The location of the certificate files. Typically references a module's files.

e.g. *'puppet:///site_certs'* will search for the mount point defined in `fileserver.conf` on the Puppet Server for the specified files.

## Limitations

This module is CI tested against [open source Puppet](https://docs.puppetlabs.com/puppet) on:
- CentOS 6 and 7
- RHEL 6 and 7

This module also provides functions for other distributions and operating systems, such as FreeBSD and Gentoo, but is not formally tested on them and are subject to regressions.

## Contributors

Riccardo Calixte ([@rcalixte](https://github.com/rcalixte))

Andrew Teixeira ([@coreone](https://github.com/coreone))

[More contributors.](https://github.com/broadinstitute/puppet-certs/graphs/contributors)
