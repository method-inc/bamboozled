# Bamboozled
A Ruby Wrapper for the BambooHR API http://www.bamboohr.com

[![Gem Version](https://badge.fury.io/rb/bamboozled.svg)](http://badge.fury.io/rb/bamboozled) [![Code Climate](https://codeclimate.com/github/Skookum/bamboozled.png)](https://codeclimate.com/github/Skookum/bamboozled)

Bamboozled wraps the BambooHR API without the use of Rails dependencies.

# Usage:

```ruby
# Create the client:
client = Bamboozled::Client.new('your_subdomain', 'your_api_key')
```

Now do cool stuff:

```ruby
# Employee data:
client.all_employees
client.employee(your_employee_id)
client.employee_job_info(your_employee_id)
client.employee_employment_status(your_employee_id)
client.employee_contacts(your_employee_id)

# Time off data
client.time_off_requests(employeeId: your_employee_id)
client.estimate_time_off(your_employee_id, '2014-12-31') # Also takes a Time or Date object
client.whos_out(Time.now, '2014-12-31')
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

