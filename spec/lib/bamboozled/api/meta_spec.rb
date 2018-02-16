require "spec_helper"

RSpec.describe "Meta" do
  before do
    @client = Bamboozled.client(subdomain: "x", api_key: "x")
  end

  def get_response(fixture_name)
    File.new(fixture_name)
  end

  def make_stub(response)
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)
  end

  it "Gets all users" do
    res = get_response("spec/fixtures/meta_users.json")
    make_stub(res)

    users = @client.meta.users
    expect(users).to be_a Array
  end

  it "Gets all fields" do
    res = get_response("spec/fixtures/meta_fields.json")
    make_stub(res)

    fields = @client.meta.fields
    expect(fields).to be_a Array
  end

  it "Gets the lists" do
    res = get_response("spec/fixtures/meta_lists.json")
    make_stub(res)

    fields = @client.meta.lists
    expect(fields).to be_a Array
  end

  it "Gets the tables" do
    res = get_response("spec/fixtures/meta_tables.json")
    make_stub(res)

    fields = @client.meta.lists
    expect(fields).to be_a Hash
  end
end
