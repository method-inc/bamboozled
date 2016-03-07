require "spec_helper"

RSpec.describe "Employees" do
  before do
    @client = Bamboozled.client(subdomain: "x", api_key: "x")
  end

  it "Gets data in a hash with indifferent access" do
    response = File.new("spec/fixtures/one_employee.json")
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    employee = @client.employee.find(1234)

    expect(employee).to be_a Hash
    expect(employee.count).to eq 3
    expect(employee["firstName"]).to eq "John"
    expect(employee[:firstName]).to eq "John"
    expect(employee["lastName"]).to eq "Doe"
    expect(employee[:lastName]).to eq "Doe"
  end

  it "Gets all employees" do
    response = File.new("spec/fixtures/all_employees.json")
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    employees = @client.employee.all

    expect(employees).to be_a Array
    expect(employees.first.count).to eq 7
  end

  it "Gets one employee" do
    response = File.new("spec/fixtures/one_employee.json")
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    employee = @client.employee.find(1234)

    expect(employee).to be_a Hash
    expect(employee.count).to eq 3
    expect(employee["firstName"]).to eq "John"
    expect(employee["lastName"]).to eq "Doe"
  end

  it "Gets employee job info" do
    response = File.new("spec/fixtures/job_info.xml")
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    info = @client.employee.job_info(1234)

    expect(info).to be_a Hash
    expect(info[:table][:row].first[:employeeId]).to eq "100"

    info[:table][:row].first[:field].each do |f|
      case f[:id]
      when "location"
        expect(f[:__content__]).to eq "New York Office"
      when "division"
        expect(f[:__content__]).to eq "Sprockets"
      when "department"
        expect(f[:__content__]).to eq "Research and Development"
      when "jobTitle"
        expect(f[:__content__]).to eq "Machinist"
      when "reportsTo"
        expect(f[:__content__]).to eq "John Smith"
      end
    end
  end

  it "Gets an employee's time off estimate" do
    response = File.new("spec/fixtures/time_off_estimate.json")
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    future = Time.now + (60 * 60 * 24 * 180)
    estimate = @client.employee.time_off_estimate(1234, future)

    expect(estimate).to be_a Hash
    expect(estimate["estimates"].keys).to match_array %w(end estimate)
    expect(estimate["estimates"]["estimate"].count).to eq 2
    expect(estimate["estimates"]["estimate"].first.keys)
      .to match_array %w(timeOffType name units balance)
  end

  it "returns the proper url using employee email address" do
    hashed = "4fdce145bab6d27d69e34403f99fd11c" # Hash of me@here.com
    required_url = "http://x.bamboohr.com/employees/photos/?h=#{hashed}"

    # Normal
    url = @client.employee.photo_url("me@here.com")
    expect(url).to eq required_url

    # Email with spaces
    url = @client.employee.photo_url(" me@here.com ")
    expect(url).to eq required_url

    # Uppercase emails
    url = @client.employee.photo_url("ME@HERE.COM")
    expect(url).to eq required_url
  end

  it "returns the proper url using employee id" do
    response = File.new("spec/fixtures/employee_emails.json")
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    hashed = "4fdce145bab6d27d69e34403f99fd11c"
    required_url = "http://x.bamboohr.com/employees/photos/?h=#{hashed}"

    url = @client.employee.photo_url(123)
    expect(url).to eq required_url
  end

  it "Gets all employee records which have changed since a given date" do
    response = File.new("spec/fixtures/last_changed.json")
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    employees = @client.employee.last_changed("2011-06-02T19:26:23+00:00")

    expect(employees).to be_a Hash
    expect(employees.keys.count).to eq 4
  end

  describe "#add" do
    it "creates a new employee in BambooHR" do
      xml = YAML.load_file("spec/fixtures/add_employee_xml.yml")
      response = File.new("spec/fixtures/add_employee_response.json")
      details = JSON.parse(File.read("spec/fixtures/add_employee_details.json"))

      stub_request(:post, /.*api\.bamboohr\.com.*/)
        .with(xml).to_return(response)

      employee = @client.employee.add(details)
      location = employee["headers"]["location"]

      expect(location).to eq "https://api.bamboohr.com/api/gateway.php/alphasights/v1/employees/44259"
    end
  end

  describe "#update" do
    it "updates an employee in BambooHR" do
      xml = YAML.load_file("spec/fixtures/update_employee_xml.yml")
      response = File.new("spec/fixtures/update_employee_response.json")
      details = JSON.parse(File.read("spec/fixtures/update_employee_details.json"))
      url = "https://x:x@api.bamboohr.com/api/gateway.php/x/v1/employees/1234"

      stub_request(:post, url).with(xml).to_return(response)
      employee = @client.employee.update("1234", details)
      expected_headers = {
        "content-type" => ["application/json; charset=utf-8"],
        "date"         => ["Tue, 17 Jun 2014 19:25:35 UTC"]
      }

      expect(employee["headers"]).to eq(expected_headers)
    end
  end
end
