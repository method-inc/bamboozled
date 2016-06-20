require "spec_helper"

RSpec.describe "Api/Base" do
  before do
    @client = Bamboozled.client(subdomain: "x", api_key: "x")
  end

  context "When access is forbidden" do
    it "returns an exception" do
      stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(status: 403)
      expect { @client.employee.all }.to raise_error Bamboozled::Forbidden
    end
  end
end
