## Release 2.4.0 (July 26, 2018)

### Summary
* Add support for an array of services in `service` parameter #16
* Rewrite `service` parameter entirely - proper values are now Array[String], Boolean, or String

## Release 2.3.2 (July 24, 2018)

### Summary
* Fix service notifications to work with global definitions as well as per-node definitions

## Release 2.3.1 (June 18, 2018)

### Summary
* Fix for variable ordering
* Ensure global definitions actually work...

## Release 2.3.0 (June 18, 2018)

### Summary
* Adding support for global definitions for CA and chain properties as well as the source path

## Release 2.2.1 (June 7, 2018)

### Summary
* Update metadata for #30
* Adding info for `null` service definitions

## Release 2.2.0 (May 18, 2018)

### Summary
* Switching the `validate_x509` parameter to default to false until it is fully working as intended
* Adding usage info for `validate_x509` to the README

## Release 2.1.1 (May 16, 2018)

### Summary
* Minor fix for lint

## Release 2.1.0 (May 16, 2018)

### Summary
* The `validate_x509` boolean parameter has been added to support the option to validate OpenSSL certificate and key pairs with the stdlib function `validate_x509_rsa_key_pair`

## Release 2.0.0 (May 15, 2018)

### Summary
* Updating puppetlabs-stdlib dependency to minimum 4.12.0
* Drop support for Puppet 3.x (Thanks to Jo Rhett)

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
