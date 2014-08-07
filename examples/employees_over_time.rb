# File: employees_over_time.rb
# Date Created: 2014-08-07
# Author(s): Mark Rickert (mjar81@gmail.com) / Skookum Digital Works (http://skookum.com)
#
# Description: This example script grabs all the historical users in BambooHR
# and determines how many employees there were at the end of each of the
# previous 12 months.
#
# Run this script with: ruby employees_over_time.rb

require '../lib/bamboozled/'
require 'active_support'
require 'active_support/core_ext/integer'
require 'active_support/core_ext/date'

@subdomain = 'your_subdomain'
@api_key   = 'your_api_key'

def main
  client = Bamboozled.client(subdomain:@subdomain, api_key:@api_key)

  # Get all users in the system. Even terminated employees.
  # Calling client.employee.all only gets active users.
  employee_data = client.meta.users.map do |e|
    # Sometimes employees are in the system but don't have an emaployee ID.
    # This makes them unqueryable and they're usually a duplicate or admin user.
    next unless e[:employeeId]

    # Get each employee's start_date and termination date
    client.employee.find(e[:employeeId], %w(displayName department hireDate terminationDate))
  end.compact.reject{|e| e['hireDate'] == '0000-00-00'}

  # Start from today and go back 12 months and print out how many employees were
  # at the company on that date.
  d = (Date.today - 1.month).end_of_month
  12.times do
    d = (d - 1.month).end_of_month
    puts "#{d},#{employees_on_date(employee_data, d)}"
  end

end

# Simple method to compare hire and termination dates and get the count of employees
# who were with the company on that day.
def employees_on_date(employees, date)
  employees.map do |e|
    hire_date = Date.parse(e["hireDate"]) rescue nil
    termination_date = Date.parse(e["terminationDate"]) rescue nil
    (hire_date <= date && (termination_date.nil? || termination_date >= date)) ? 1 : 0
  end.inject(:+)
end

main
