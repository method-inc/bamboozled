require "spec_helper"

RSpec.describe "Reports" do
  before do
    @client = Bamboozled.client(subdomain: "x", api_key: "x")
  end

  it "Creates a custom report" do
    response = File.new("spec/fixtures/custom_report.json")
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    employees = @client.report.custom(%w(bestEmail employeeNumber birthday))

    expect(employees).to be_an Array
    expect(employees.size).to eq 2
  end
end
