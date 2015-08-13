# Bamboozled

[![Gem Version](https://badge.fury.io/rb/bamboozled.svg)](http://badge.fury.io/rb/bamboozled) [![Code Climate](https://codeclimate.com/github/Skookum/bamboozled.png)](https://codeclimate.com/github/Skookum/bamboozled) [![Build Status](https://travis-ci.org/Skookum/bamboozled.svg?branch=master)](https://travis-ci.org/Skookum/bamboozled)

Bamboozled wraps the [BambooHR API](http://www.bamboohr.com/api/documentation/) without the use of Rails dependencies. Currently, this gem is **READ-ONLY**.

# Usage:

Install the gem with `gem install bamboozled` or add this to your `Gemfile`: `gem 'bamboozled'`

```ruby
# Create the client:
client = Bamboozled.client(subdomain: 'your_subdomain', api_key: 'your_api_key')
```

> TIP! Create an API key by logging into your BambooHR account, then click your image in the upper right corner and select "API Keys". Then click "Add A New Key".

### Employee related data:

You can pass an array of fields to `all` or `:all` to get all fields your user is allowed to access. Because BambooHR's API doesn't allow for specifying fields on the `/employees/directory` API endpoint, passing a list of fields to retrieve will be signifigantly slower than getting just the default fields since the gem will get the directory of employees, then request the data for each individual employee resulting in `employees.count + 1` API calls.

```ruby
# Returns an array of all employees
client.employee.all # Gets all employees with default fields
client.employee.all(:all) # Gets all fields for all employees
client.employee.all(['hireDate', 'displayName'])
client.employee.all('hireDate,displayName')

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
client.time_off.whos_out(Time.now, '2014-12-31')
```

# Reports

```ruby
# Find a report by its number
client.report.find(report_number, format = 'JSON', fd = true)
```

# Metadata

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

## Todo:

1. Write more tests!
2. Implement CRUD so the gem is not read-only any more.
2. ~~Implement photos endpoints.~~
3. ~~Implement metadata endpoints.~~
4. Implement last change information endpoints.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Make some specs pass
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

## License

MIT. See the [LICENSE](/LICENSE) file.
