require "spec_helper"

RSpec.describe "Meta" do

  before do
    @client = Bamboozled.client(subdomain: "x", api_key: "x")
  end

  it "Gets all users" do
    response = File.new("spec/fixtures/meta_users.json")
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    users = @client.meta.users
    expect(users).to be_a Array
  end

  it "Gets all fields" do
    response = File.new("spec/fixtures/meta_fields.json")
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    fields = @client.meta.fields
    expect(fields).to be_a Array
  end

  it "Gets the lists" do
    response = File.new("spec/fixtures/meta_lists.json")
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    fields = @client.meta.lists
    expect(fields).to be_a Array
  end
end
