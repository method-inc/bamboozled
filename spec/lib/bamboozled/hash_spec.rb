require "spec_helper"

RSpec.describe "HashWithIndifferentAccess" do
  before do
    @client = Bamboozled.client(subdomain:'x', api_key:'x')
  end

  it "Gets data in a hash with indifferent access" do
    response = File.new('spec/fixtures/one_employee.json')
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    employee = @client.employee.find(1234)

    expect(employee).to be_a Hash
    expect(employee.count).to eq 3
    expect(employee["firstName"]).to eq "John"
    expect(employee[:firstName]).to eq "John"
    expect(employee["lastName"]).to eq "Doe"
    expect(employee[:lastName]).to eq "Doe"
  end
end
