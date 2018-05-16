## Release 2.1.1 (May 16, 2018)

### Summary
* Minor fix for lint

## Release 2.1.0 (May 16, 2018)

### Summary
* The `validate_x509` boolean parameter has been added to support the option to validate OpenSSL certificate and key pairs with the stdlib function `validate_x509_rsa_key_pair`

## Release 2.0.0 (May 15, 2018)

### Summary
* Updating puppetlabs-stdlib dependency to minimum 4.12.0
* Drop support for Puppet 3.x

## Release 1.2.1 (August 2, 2017)

### Summary
* Fix a small string vs. boolean bug in new dhparam code

## Release 1.2.0 (July 28, 2017)

### Summary
* Introducing an option to add a Diffie-Helman parameters file, including the ability to merge the file with the certificate file if necessary
* Many more and expanded spec tests, along with spec test cleanup

## Release 1.1.0 (January 17, 2017)

### Summary
* Introducing an option to merge the private key into certificates for services that require it
* Update spec replacing `should` with `is_expected.to` for all tests

### Features
* The `merge_key` parameter has been added to support merging private keys with certificates when required.

## Release 1.0.0 (September 6, 2016)

### Summary
* Introducing new features, primarily an option to merge certificates for services that require it
* Adding Vagrant support for testing using Puppet 4
* Travis configuration fixes
* Rewriting parameters for the module
* Adding spec tests

### Features
* The `cert_dir_mode`, `key_dir_mode`, and `merge_chain` parameters have been added to support directory modes for certificates and keys and to also merge certificates when required.

### Changes
* Module parameters are now capable of being defined globally in the base class.

## Release 0.4.0 (August 17, 2016)

### Summary
Initial release
