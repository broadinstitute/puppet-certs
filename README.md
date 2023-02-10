# certificates

![checks](https://github.com/broadinstitute/puppet-certificates/workflows/checks/badge.svg?branch=main)
[![Puppet Forge](https://img.shields.io/puppetforge/dt/broadinstitute/certificates.svg)](https://forge.puppetlabs.com/broadinstitute/certificates)
[![Puppet Forge](https://img.shields.io/puppetforge/v/broadinstitute/certificates.svg)](https://forge.puppetlabs.com/broadinstitute/certificates)
[![Puppet Forge](https://img.shields.io/puppetforge/f/broadinstitute/certificates.svg)](https://forge.puppetlabs.com/broadinstitute/certificates)
[![License (Apache 2.0)](https://img.shields.io/badge/license-Apache-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Table of Contents

* [Overview](#overview)
* [Module Description](#module-description)
* [Setup](#setup)
  * [Setup requirements](#setup-requirements)
* [Usage](#usage)
  * [Installation](#installation)
  * [Examples](#examples)
* [Reference](#reference)
* [Limitations - OS compatibility, etc.](#limitations)
* [Contributors](#contributors)

## Overview

Configures SSL certificates and keys.

## Module Description

This module provides SSL certificate files required by Apache or other services via the certificates::site define.
It can be used in conjunction with puppetlabs/apache's apache::vhost definitions to provide the ssl_cert and ssl_key files or any other service requiring SSL certificates.

It can also be used independent of any Puppet-defined service that requires the files to exist on a managed node.

## Setup

### Setup Requirements

The certificate files must come from an external store. Recommended stores are a site-specific (and private) module containing SSL files or a network-accessible filesystem, such as NFS, that the managed node can access.
Once a file store is determined, include at least one certificates::site define and specify the file store location as the `source_path`.

By default, this module will place certificates and keys in their relative locations and restart the specified service, provided it is defined in the catalog.

* **RedHat**
  * certificates directory: `/etc/pki/tls/certs`
  * keys directory: `/etc/pki/tls/private`
  * service: `httpd`

* **Debian & Suse**
  * certificates directory: `/etc/ssl/certs`
  * keys directory: `/etc/ssl/private`
  * service: `apache2`

* **FreeBSD**
  * certificates directory: `/usr/local/etc/apache24`
  * keys directory: `/usr/local/etc/apache24`
  * service: `apache24`

* **Gentoo**
  * certificates directory: `/etc/ssl/apache2`
  * keys directory: `/etc/ssl/apache2`
  * service: `apache2`

## Usage

No trailing slashes should be provided for any paths.

## Installation

**Puppet Forge:**

``` sh
puppet module install broadinstitute-certificates
```

**Puppetfile:**

``` sh
mod 'broadinstitute/certificates'
```

## Examples

### Puppet Manifest

`manifest.pp`

```puppet
  include certificates
  $domain = 'www.example.com'
  certificates::site { $domain:
    source_path    => 'puppet:///site_certificates',
    ca_cert        => true,
    ca_name        => 'caname',
    ca_source_path => 'puppet:///ca_certs',
  }
```

### With Hiera

`node.yaml`

```yaml
  classes:
    - certificates
  certificates::sites:
    'www.example.com':
      source_path: 'puppet:///site_certificates'
      ca_cert: true
      ca_name: 'caname'
      ca_source_path: 'puppet:///ca_certs'
```

### Resource Chaining with Apache Module

`manifest.pp`

```puppet
  Certificates::Site<| |> -> Apache::Vhost<| |>
```

### Global Defaults

You can also reset some of the settings in params.pp globally via the **certificates** base class which will be inherited by all **certificates::site** defines used that are later defined.  In this example, we can reset the default certificate and key paths for all instantiated sites so that we don't have to manually set the custom path in each site:

```puppet
  $domain1 = 'www.example.com'
  $domain2 = 'foo.example.com'

  class { 'certificates':
    cert_path => '/path/to/certs',
    key_path  => '/path/to/keys',
  }

  certificates::site { $domain1:
    source_path    => 'puppet:///site_certificates',
    ca_cert        => true,
    ca_name        => 'caname',
    ca_source_path => 'puppet:///ca_certs',
  }

  certificates::site { $domain2:
    source_path    => 'puppet:///site_certificates',
    ca_cert        => true,
    ca_name        => 'caname',
    ca_source_path => 'puppet:///ca_certs',
  }
```

## Reference

[REFERENCE.md](REFERENCE.md) (generated with Puppet Strings)

## Limitations

This module is CI tested against [open source Puppet](https://docs.puppetlabs.com/puppet) on:

* CentOS 7, 8, 9
* RHEL 7, 8, 9

This module also provides functions for other distributions and operating systems, such as FreeBSD and Gentoo, but is not formally tested on them and are subject to regressions.

## Contributors

Riccardo Calixte ([@rcalixte](https://github.com/rcalixte))

Andrew Teixeira ([@coreone](https://github.com/coreone))

[More contributors.](https://github.com/broadinstitute/puppet-certificates/graphs/contributors)
