require 'httparty'
require 'json'
require 'uri'

require_relative './bamboozled/ext/yesno'

require_relative './bamboozled/version'
require_relative './bamboozled/errors'
require_relative './bamboozled/base'

%w(base employee report time_off meta tabular).each do |a|
  require_relative "./bamboozled/api/#{a}"
end

module Bamboozled
  class << self
    # Creates a standard client that will raise all errors it encounters
    def client(subdomain: nil, api_key: nil)
      Bamboozled::Base.new(subdomain: subdomain, api_key: api_key)
    end
  end
end
