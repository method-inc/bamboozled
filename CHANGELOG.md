# Changelog

## develop (unreleased)

### New Features

### Changes

### Bug Fixes

## 0.3.0 (2019-08-15)

### New Features

- New api `ApplicantTracking` allows fetching of applicant tracking data. At this time it is currently in **beta**. ([@danhealy][])

### Changes

- Updating the versions of the following dependencies ([@cabello][])
  - `"httparty", "~> 0.17"`
  - `"json", "~> 2"`

## 0.2.0 (2019-03-01)

### New Features

- New method `Report#custom` allows fetching a custom report of employees. ([@artfuldodger][])
- Make httpparty options configurable ([@ivanovv][])
- Add time tracking api interface ([@nlively][])

### Changes

- Using github actions for linting and testing

### Bug Fixes

- Fix Metadata API calls. Fixes [Issue #38](https://github.com/Skookum/bamboozled/issues/36) and [Issue #5](https://github.com/Skookum/bamboozled/issues/5)

## 0.1.0 (2016-06-14)

### New Features

- New method `Employee#add` allows client to create new employees. ([@kylefdoherty][])
- New method `Employee#update` allows client to update new employees. ([@kylefdoherty][])

### Changes

### Bug Fixes

- Added missing documentation for `Employee#add`. ([@mjording][])

[@markrickert]: https://github.com/markrickert
[@enriikke]: https://github.com/Enriikke
[@kylefdoherty]: https://github.com/kylefdoherty
[@mjording]: https://github.com/mjording
[@artfuldodger]: https://github.com/artfuldodger
[@splybon]: https://github.com/splybon
[@chrisman]: https://github.com/chrisman
[@ivanovv]: https://github.com/ivanovv
[@nlively]: https://github.com/nlively
[@danhealy]: https://github.com/danhealy
[@cabello]: https://github.com/cabello
