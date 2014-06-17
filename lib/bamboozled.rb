require 'httparty'
require 'json'
require 'uri'

require 'bamboozled/ext/yesno'

require 'bamboozled/version'
require 'bamboozled/errors'
require 'bamboozled/base'

%w(base employee report time_off).each {|a| require "bamboozled/api/#{a}"}

module Bamboozled
  class << self
    # Creates a standard client that will raise all errors it encounters
    def client(subdomain: nil, api_key: nil)
      Bamboozled::Base.new(subdomain: subdomain, api_key: api_key)
    end
  end
end
