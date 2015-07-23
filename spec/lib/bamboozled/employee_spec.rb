require_relative '../../spec_helper'

describe "Employees" do

  before do
    @client = Bamboozled.client(subdomain:'x', api_key:'x')
  end

  it "Gets all employees" do
    response = File.new('spec/fixtures/all_employees.json')
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    employees = @client.employee.all

    employees.is_a?(Array).must_equal true
    employees.first.count.must_equal 7
  end

  it "Gets one employee" do
    response = File.new('spec/fixtures/one_employee.json')
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    employee = @client.employee.find(1234)

    employee.is_a?(Hash).must_equal true
    employee.count.must_equal 3
    employee['firstName'].must_equal "John"
    employee['lastName'].must_equal "Doe"
  end

  it "Gets employee job info" do
    response = File.new('spec/fixtures/job_info.xml')
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    info = @client.employee.job_info(1234)

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

    future = Time.now + (60 * 60 * 24 * 180)
    estimate = @client.employee.time_off_estimate(1234, future)

    puts estimate

    estimate.is_a?(Hash).must_equal true
    estimate['estimates'].keys.must_equal ['end', 'estimate']
    estimate['estimates']['estimate'].count.must_equal 2
    estimate['estimates']['estimate'].first.keys.must_equal ['timeOffType', 'name', 'units', 'balance']
  end

  it 'returns binary data for an employee email' do

  end

  it 'returns the proper url using employee email address' do

    hashed = '4fdce145bab6d27d69e34403f99fd11c' # Hash of me@here.com
    required_url = "http://x.bamboohr.com/employees/photos/?h=#{hashed}"

    # Normal
    url = @client.employee.photo_url('me@here.com')
    url.must_equal required_url

    # Email with spaces
    url = @client.employee.photo_url(' me@here.com ')
    url.must_equal required_url

    # Uppercase emails
    url = @client.employee.photo_url('ME@HERE.COM')
    url.must_equal required_url
  end

  it 'returns the proper url using employee id' do
    response = File.new('spec/fixtures/employee_emails.json')
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    hashed = '4fdce145bab6d27d69e34403f99fd11c'
    required_url = "http://x.bamboohr.com/employees/photos/?h=#{hashed}"

    url = @client.employee.photo_url(123)
    url.must_equal required_url
  end

  describe "#add" do
    it 'creates a new employee in BambooHR' do

      xml = YAML.load_file('spec/fixtures/add_employee_xml.yml')
      response = File.new('spec/fixtures/add_employee_response.json')
      details = JSON.parse(File.read('spec/fixtures/add_employee_details.json'))

      stub_request(:post, /.*api\.bamboohr\.com.*/).
        with(xml).to_return(response)

      employee = @client.employee.add(employee_details: details)

      employee["headers"]["location"].
        must_equal "https://api.bamboohr.com/api/gateway.php/alphasights/v1/employees/44259"
    end
  end

  # TODO - Figure out how to test this with webmock
  # it 'returns binary data for an employee photo' do
  # end

end

