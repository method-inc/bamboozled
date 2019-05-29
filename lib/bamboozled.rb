require "httparty"
require "json"
require "uri"

require "bamboozled/version"
require "bamboozled/base"
require "bamboozled/errors"
require "bamboozled/ext/yesno"
require "bamboozled/api/base"
require "bamboozled/api/field_collection"
require "bamboozled/api/applicant_tracking"
require "bamboozled/api/employee"
require "bamboozled/api/report"
require "bamboozled/api/time_off"
require "bamboozled/api/time_tracking"
require "bamboozled/api/meta"

module Bamboozled
  class << self
    # Creates a standard client that will raise all errors it encounters
    def client(subdomain: nil, api_key: nil, httparty_options: {})
      Bamboozled::Base.new(subdomain: subdomain, api_key: api_key, httparty_options: httparty_options)
    end
  end
end
