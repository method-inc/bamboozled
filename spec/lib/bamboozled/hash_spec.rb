require_relative '../../spec_helper'

describe "HashWithIndifferentAccess" do

  before do
    @client = Bamboozled.client(subdomain:'x', api_key:'x')
  end

  it "Gets data in a hash with indifferent access" do
    response = File.new('spec/fixtures/one_employee.json')
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    employee = @client.employee.find(1234)

    employee.is_a?(Hash).must_equal true
    employee.count.must_equal 3
    employee['firstName'].must_equal "John"
    employee['lastName'].must_equal "Doe"

    employee[:firstName].must_equal "John"
    employee[:lastName].must_equal "Doe"
  end

end
