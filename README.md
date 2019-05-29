[![Gem Version](https://img.shields.io/gem/v/bamboozled.svg)][rubygems]
[![Build Status](https://img.shields.io/travis/Skookum/bamboozled.svg)][travis]
[![Code Climate](https://img.shields.io/codeclimate/github/Skookum/bamboozled.svg)][codeclimate]
[![Coverage Status](https://img.shields.io/coveralls/Skookum/bamboozled.svg)][coveralls]
[![Inline Docs](http://inch-ci.org/github/Skookum/bamboozled.svg?style=shields)][inchdocs]

[rubygems]: https://rubygems.org/gems/bamboozled
[travis]: https://travis-ci.org/Skookum/bamboozled
[codeclimate]: https://codeclimate.com/github/Skookum/bamboozled
[coveralls]: https://coveralls.io/r/Skookum/bamboozled
[inchdocs]: http://inch-ci.org/github/Skookum/bamboozled

---

<p align="center">
  <img src="logos/bamboozled_logo_black.png" alt="Bamboozled" />
</p>

Bamboozled is a Ruby wrapper for the [BambooHR API](http://www.bamboohr.com/api/documentation/).

## Versioning

Bamboozled follows [Semantic Versioning 2.0.0](http://semver.org/). Make sure to
always bound the major version when installing if you want to avoid breaking
changes.

## Documentation

This documentation tracks the latest changes in the `master` branch of this
repo. Some of the features described might not be available in older versions of
the gem (including the current stable version). Please consult the relevant git
tag (e.g. v0.0.7) if you need documentation for a specific Bamboozled version.

## Installation

Bamboozled's installation follows the standard gem installation process:

```sh
$ gem install bamboozled
```

If you prefer to install Bamboozled through `bundler` then add it to your
`Gemfile`:

```ruby
gem "bamboozled"
```

## Usage

Create a `client` and provide it with your BambooHR subdomain and an API key:

```ruby
# Create the client:
client = Bamboozled.client(subdomain: "your_subdomain", api_key: "your_api_key")
```

> TIP! Create an API key by logging into your BambooHR account, then click your
> image in the upper right corner and select "API Keys".

### Employee related data:

You can pass an array of fields to `all` or `:all` to get all fields your user
is allowed to access. Because BambooHR's API doesn't allow for specifying fields
on the `/employees/directory` API endpoint, passing a list of fields to retrieve
will be signifigantly slower than getting just the default fields since the gem
will get the directory of employees, then request the data for each individual
employee resulting in `employees.count + 1` API calls. To get around this,
consider using a custom report.

```ruby
# Returns an array of all employees
client.employee.all # Gets all employees with default fields
client.employee.all(:all) # Gets all fields for all employees
client.employee.all(["hireDate", "displayName"])
client.employee.all("hireDate,displayName")

# Get the employee records which have changed since a given date
client.employee.last_changed("2015-01-01T00:00:00-08:00", :updated)
client.employee.last_changed("2015-01-01T00:00:00-08:00", :inserted)
client.employee.last_changed("2015-01-01T00:00:00-08:00", :deleted)
client.employee.last_changed("2015-01-01T00:00:00-08:00") # Return all changes

# Returns a hash of a single employee
client.employee.find(employee_id, fields = nil)

# Adds an employee
client.employee.add(employee_details_hash)

# Tabular employee data
client.employee.job_info(employee_id)
client.employee.employment_status(employee_id)
client.employee.compensation(employee_id)
client.employee.dependents(employee_id)
client.employee.contacts(employee_id)

# Time off estimate for employee. Requires end date in Date or Time format or YY-MM-DD string.
client.employee.time_off_estimate(employee_id, end_date)

# Photos for an employee
client.employee.photo_url(employee_work_email)
client.employee.photo_url(employee_id)
client.employee.photo_binary(employee_id)
```

### Time off data

```ruby
# Get time off requests filtered by a number of parameters
# :id - the ID of the time off request
# :action -
# :employeeId - the ID of the employee you're looking for
# :start - filter start date
# :end - filter end date
# :type - type of time off request
# :status - must be one or more of the following: approved denied superceded requested canceled
client.time_off.requests(:employeeId: employee_id, start: Time.now)

# See who is out when.
client.time_off.whos_out(Time.now, "2014-12-31")
```

### Reports

```ruby
# Get a list of employees with specified fields
# Send `:all` for `fields` to get all fields.
# Note that this can get a list of employees with additional fields via a single
# API request instead of one per employee when using the `employees` endpoint.
client.report.custom(fields, format = "JSON")
```


```ruby
# Find a report by its number
client.report.find(report_number, format = "JSON", fd = true)
```

### Applicant Tracking System
The ATS API is currently in **beta**. Please note that BambooHR may make breaking changes without
warning. Refer to the [documentation](https://www.bamboohr.com/api/documentation/ats.php) for
details.

```ruby
# Get a list of job summaries
client.applicant_tracking.job_summaries

# Get a list of applications, following pagination
client.applicant_tracking.applications(page_limit: 10)

# Get the details of an application
client.applicant_tracking.application(123)

# Add comments to an application
client.applicant_tracking.add_comment(123, "Great Application!")

# Get a list of statuses for a company
client.applicant_tracking.statuses

# Change applicant's status
client.applicant_tracking.change_status(123, 3)
```

### Metadata

```ruby
# Get fields
client.meta.fields
# Get lists
client.meta.lists
# Get tables
client.meta.tables
# Get users
# Note: this is all uses in the system, whereas client.employee.all only gets active employees
client.meta.users
```

## Contributing

Thank you for contributing! We always welcome bug reports and/or pull requests.
Please take the time to go through our [contribution guidelines](CONTRIBUTING.md).

Special thanks to all the awesome people who have helped make this gem better.
You can see a list of them [here](https://github.com/Skookum/bamboozled/graphs/contributors).

## License

This project is licensed under the terms of the MIT license. See the
[LICENSE](/LICENSE) file.

---

<p align="center">
  <img src="logos/skookum_mark_black.png" alt="Skookum" width="100" />
</p>
