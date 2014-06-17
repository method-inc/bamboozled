# Bamboozled

[![Gem Version](https://badge.fury.io/rb/bamboozled.svg)](http://badge.fury.io/rb/bamboozled) [![Code Climate](https://codeclimate.com/github/Skookum/bamboozled.png)](https://codeclimate.com/github/Skookum/bamboozled)

Bamboozled wraps the BambooHR API without the use of Rails dependencies.

# Usage:

```ruby
# Create the client:
client = Bamboozled.client('your_subdomain', 'your_api_key')
```

### Employee related data:

```ruby
# Returns an array of all employees
client.employee.all

# Returns a hash of a single employee
client.employee.find(employee_id, fields = nil)

# Tabular employee data
client.employee.job_info(employee_id)
client.employee.employment_status(employee_id)
client.employee.compensation(employee_id)
client.employee.dependents(employee_id)
client.employee.contacts(employee_id)

# Time off estimate for employee. Requires end date in Date or Time format or YY-MM-DD string.
client.employee.time_off_estimate(employee_id, end_date)
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

## Todo:

1. Write tests!
2. Implement photos endpoints
3. Implement metadata endpoints
4. Implement last change information endpoints

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Make some specs pass
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

