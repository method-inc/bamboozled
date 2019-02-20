require "spec_helper"

RSpec.describe "Bamboozled::API::Base" do
  it "accepts a hash as first constructor parameter" do
    expect do
      Bamboozled::API::Base.new({ subdomain: 'x', api_domain: 'api.bamboohr.co.uk' }, "x", { log_format: :curl })
    end.not_to raise_error
  end

  it "uses subdomain and api_domain from first parameter if has provided" do
    response = double("response", code: 200, body: "{}", to_str: "{}")

    expect(HTTParty).to receive(:get).
      with("https://api.bamboohr.co.uk/api/gateway.php/x/v1/test", hash_including(log_format: :curl)).
      and_return(response)

    base = Bamboozled::API::Base.new({ subdomain: 'x', api_domain: 'api.bamboohr.co.uk' }, "x", { log_format: :curl })
    base.send(:request, :get, "test")
  end

  it "takes HTTParty options as a constructor parameter" do
    expect { Bamboozled::API::Base.new("x", "x", { log_format: :curl }) }.not_to raise_error
  end

  it "uses passed HTTParty options" do
    response = double("response", code: 200, body: "{}", to_str: "{}")

    expect(HTTParty).to receive(:get).
      with("https://api.bamboohr.com/api/gateway.php/x/v1/test", hash_including(log_format: :curl)).
      and_return(response)

    base = Bamboozled::API::Base.new("x", "x", { log_format: :curl })
    base.send(:request, :get, "test")
  end
end
