require "spec_helper"

RSpec.describe "Bamboozled" do
  it "takes HTTParty options as a parameter" do
    expect(Bamboozled::Base).to receive(:new).with(subdomain: "x", api_key: "x", httparty_options: { log_format: :curl })
    Bamboozled.client(subdomain: "x", api_key: "x", httparty_options: { log_format: :curl })
  end

  it "throws no errors if no HTTParty options were provided (they are optional)" do
    expect { Bamboozled.client(subdomain: "x", api_key: "x") }.not_to raise_error
  end

  it "passes HTTParty params to HTTParty" do
    logger = double("logger")
    allow(Time).to receive_message_chain(:now, :strftime).and_return("Time.now")
    expect(logger).to receive(:info).with('[HTTParty] [Time.now] 200 "GET https://api.bamboohr.com/api/gateway.php/x/v1/employees/1234?fields=" - ')

    client = Bamboozled.client(subdomain: "x", api_key: "x", httparty_options: { log_format: :apache, logger: logger })
    response = File.new("spec/fixtures/one_employee.json")
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    employee = client.employee.find(1234)
  end

  it "works without HTTParty options provided" do
    client = Bamboozled.client(subdomain: "x", api_key: "x")
    response = File.new("spec/fixtures/one_employee.json")
    stub_request(:any, /.*api\.bamboohr\.com.*/).to_return(response)

    employee = client.employee.find(1234)
    expect(employee["firstName"]).to eq "John"
  end
end
