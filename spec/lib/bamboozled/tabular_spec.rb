require_relative '../../spec_helper'
require 'pry'

describe "Employees" do

  before do
    @client = Bamboozled.client(subdomain:'x', api_key:'x')
  end

  describe "#add_position" do
    it "adds a position row to the specified table in BambooHR" do
      xml = YAML.load_file('spec/fixtures/add_row_xml.yml')
      response = File.new('spec/fixtures/add_row_response.json')
      details = JSON.parse(File.read('spec/fixtures/add_row_details.json'))

      stub_request(:post, /.*api\.bamboohr\.com.*/).with(xml).to_return(response)

      response = @client.tabular.add_row(table_name: "jobInfo", details: details, employee_id: 12345)

      expect(response["code"]).to eq("200")
    end
  end
end
