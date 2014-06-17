require_relative '../../spec_helper'

describe "Employees" do

  it "Gets all employees" do
    response = File.new('spec/fixtures/all_employees.json')
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    client = Bamboozled.client(subdomain:'x', api_key:'x')
    employees = client.employee.all

    employees.is_a?(Array).must_equal true
    employees.first.count.must_equal 7
  end

  it "Gets one employee" do
    response = File.new('spec/fixtures/one_employee.json')
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    client = Bamboozled.client(subdomain:'x', api_key:'x')
    employee = client.employee.find(1234)

    employee.is_a?(Hash).must_equal true
    employee.count.must_equal 3
    employee['firstName'].must_equal "John"
    employee['lastName'].must_equal "Doe"
  end

  it "Gets employee job info" do
    response = File.new('spec/fixtures/job_info.xml')
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    client = Bamboozled.client(subdomain:'x', api_key:'x')
    info = client.employee.job_info(1234)

    info.is_a?(Hash).must_equal true
    info[:table][:row].first[:employeeId].must_equal "100"
    info[:table][:row].first[:field].each do |f|
      case f[:id]
      when 'location'
        f[:__content__].must_equal "New York Office"
      when 'division'
        f[:__content__].must_equal "Sprockets"
      when 'department'
        f[:__content__].must_equal "Research and Development"
      when 'jobTitle'
        f[:__content__].must_equal "Machinist"
      when 'reportsTo'
        f[:__content__].must_equal "John Smith"
      end
    end
  end

  it "Gets an employee's time off estimate" do
    response = File.new('spec/fixtures/time_off_estimate.json')
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    client = Bamboozled.client(subdomain:'x', api_key:'x')
    future = Time.now + (60 * 60 * 24 * 180)
    estimate = client.employee.time_off_estimate(1234, future)

    puts estimate

    estimate.is_a?(Hash).must_equal true
    estimate['estimates'].keys.must_equal ['end', 'estimate']
    estimate['estimates']['estimate'].count.must_equal 2
    estimate['estimates']['estimate'].first.keys.must_equal ['timeOffType', 'name', 'units', 'balance']
  end

end
