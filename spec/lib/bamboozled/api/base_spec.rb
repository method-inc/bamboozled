require "spec_helper"

RSpec.describe "Bamboozled::API::Base" do
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
