# Change log

All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

## [2.5.1](https://github.com/broadinstitute/puppet-certs/tree/2.5.1) (2020-01-27)

[Full Changelog](https://github.com/broadinstitute/puppet-certs/compare/2.5.0...2.5.1)

### Added

- Convert to PDK [\#44](https://github.com/broadinstitute/puppet-certs/pull/44) ([coreone](https://github.com/coreone))

### Fixed

- Make dhparam directory customizable \(Fixes \#38\) [\#45](https://github.com/broadinstitute/puppet-certs/pull/45) ([coreone](https://github.com/coreone))
- Fix ensure\_resource on multiple directories not working correctly [\#43](https://github.com/broadinstitute/puppet-certs/pull/43) ([coreone](https://github.com/coreone))

## [2.5.0](https://github.com/broadinstitute/puppet-certs/tree/2.5.0) (2018-07-27)

[Full Changelog](https://github.com/broadinstitute/puppet-certs/compare/2.4.0...2.5.0)

### Added

- Change default mode and location when merging key \#31 [\#37](https://github.com/broadinstitute/puppet-certs/pull/37) ([rcalixte](https://github.com/rcalixte))

## [2.4.0](https://github.com/broadinstitute/puppet-certs/tree/2.4.0) (2018-07-26)

[Full Changelog](https://github.com/broadinstitute/puppet-certs/compare/2.3.2...2.4.0)

### Added

- Rewrite service notifications [\#36](https://github.com/broadinstitute/puppet-certs/pull/36) ([rcalixte](https://github.com/rcalixte))

## [2.3.2](https://github.com/broadinstitute/puppet-certs/tree/2.3.2) (2018-07-24)

[Full Changelog](https://github.com/broadinstitute/puppet-certs/compare/2.3.1...2.3.2)

### Fixed

- Fix service notifications [\#35](https://github.com/broadinstitute/puppet-certs/pull/35) ([rcalixte](https://github.com/rcalixte))

## [2.3.1](https://github.com/broadinstitute/puppet-certs/tree/2.3.1) (2018-06-18)

[Full Changelog](https://github.com/broadinstitute/puppet-certs/compare/2.3.0...2.3.1)

## [2.3.0](https://github.com/broadinstitute/puppet-certs/tree/2.3.0) (2018-06-18)

[Full Changelog](https://github.com/broadinstitute/puppet-certs/compare/2.2.1...2.3.0)

### Added

- Add more global defaults [\#33](https://github.com/broadinstitute/puppet-certs/pull/33) ([rcalixte](https://github.com/rcalixte))

## [2.2.1](https://github.com/broadinstitute/puppet-certs/tree/2.2.1) (2018-06-07)

[Full Changelog](https://github.com/broadinstitute/puppet-certs/compare/2.2.0...2.2.1)

### Added

- Documentation fixes \(\#30\) [\#32](https://github.com/broadinstitute/puppet-certs/pull/32) ([rcalixte](https://github.com/rcalixte))

## [2.2.0](https://github.com/broadinstitute/puppet-certs/tree/2.2.0) (2018-05-18)

[Full Changelog](https://github.com/broadinstitute/puppet-certs/compare/2.1.1...2.2.0)

### Added

- Release 2.2.0 [\#28](https://github.com/broadinstitute/puppet-certs/pull/28) ([rcalixte](https://github.com/rcalixte))

## [2.1.1](https://github.com/broadinstitute/puppet-certs/tree/2.1.1) (2018-05-16)

[Full Changelog](https://github.com/broadinstitute/puppet-certs/compare/2.1.0...2.1.1)

## [2.1.0](https://github.com/broadinstitute/puppet-certs/tree/2.1.0) (2018-05-16)

[Full Changelog](https://github.com/broadinstitute/puppet-certs/compare/1.2.1...2.1.0)

### Added

- Add validation parameter [\#25](https://github.com/broadinstitute/puppet-certs/pull/25) ([rcalixte](https://github.com/rcalixte))
- Handle trusted certificate updates on EL6/7 [\#22](https://github.com/broadinstitute/puppet-certs/pull/22) ([jorhett](https://github.com/jorhett))
- Refactor for modern Puppet [\#21](https://github.com/broadinstitute/puppet-certs/pull/21) ([jorhett](https://github.com/jorhett))

### Fixed

- Use puppet lookup so a hash merge of sites is possible [\#20](https://github.com/broadinstitute/puppet-certs/pull/20) ([jorhett](https://github.com/jorhett))

## [1.2.1](https://github.com/broadinstitute/puppet-certs/tree/1.2.1) (2017-08-02)

[Full Changelog](https://github.com/broadinstitute/puppet-certs/compare/1.2.0...1.2.1)

### Added

- Validation for bool [\#14](https://github.com/broadinstitute/puppet-certs/pull/14) ([coreone](https://github.com/coreone))

### Fixed

- Fix boolean vs. string issue [\#13](https://github.com/broadinstitute/puppet-certs/pull/13) ([coreone](https://github.com/coreone))

## [1.2.0](https://github.com/broadinstitute/puppet-certs/tree/1.2.0) (2017-07-28)

[Full Changelog](https://github.com/broadinstitute/puppet-certs/compare/1.1.0...1.2.0)

### Added

- More dhparams stuff [\#12](https://github.com/broadinstitute/puppet-certs/pull/12) ([coreone](https://github.com/coreone))
- Add dhparam files as well as other cleanup [\#11](https://github.com/broadinstitute/puppet-certs/pull/11) ([coreone](https://github.com/coreone))

## [1.1.0](https://github.com/broadinstitute/puppet-certs/tree/1.1.0) (2017-01-17)

[Full Changelog](https://github.com/broadinstitute/puppet-certs/compare/1.0.0...1.1.0)

### Added

- merge\_key and SPEC updates [\#7](https://github.com/broadinstitute/puppet-certs/pull/7) ([coreone](https://github.com/coreone))

## [1.0.0](https://github.com/broadinstitute/puppet-certs/tree/1.0.0) (2016-09-06)

[Full Changelog](https://github.com/broadinstitute/puppet-certs/compare/0.4.0...1.0.0)

### Added

- Add tests, content instead of source logic, and ensure support [\#6](https://github.com/broadinstitute/puppet-certs/pull/6) ([coreone](https://github.com/coreone))
- Update README [\#5](https://github.com/broadinstitute/puppet-certs/pull/5) ([rcalixte](https://github.com/rcalixte))
- Testing fixes and global default settings [\#4](https://github.com/broadinstitute/puppet-certs/pull/4) ([coreone](https://github.com/coreone))
- Various fixes and cert/chain merge ability [\#3](https://github.com/broadinstitute/puppet-certs/pull/3) ([coreone](https://github.com/coreone))

## [0.4.0](https://github.com/broadinstitute/puppet-certs/tree/0.4.0) (2016-08-25)

[Full Changelog](https://github.com/broadinstitute/puppet-certs/compare/5d8732ab0fdf881256961da31e311343de59d77c...0.4.0)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
