module Bamboozled
  class Base
    attr_reader :request

    def initialize(subdomain: nil, api_domain: nil, api_key: nil, httparty_options: {})
      @subdomain, @api_key = subdomain
      @api_domain = api_domain
      @api_key = api_key
      @httparty_options = httparty_options
    end

    def employee
      @employee ||= Bamboozled::API::Employee.new(domain_options, @api_key, @httparty_options)
    end

    def report
      @report ||= Bamboozled::API::Report.new(domain_options, @api_key, @httparty_options)
    end

    def meta
      @meta ||= Bamboozled::API::Meta.new(domain_options, @api_key, @httparty_options)
    end

    def time_off
      @time_off ||= Bamboozled::API::TimeOff.new(domain_options, @api_key, @httparty_options)
    end

    def time_tracking
      @time_tracking ||= Bamboozled::API::TimeTracking.new(domain_options, @api_key, @httparty_options)
    end

    protected

    def domain_options
      {
        subdomain: @subdomain,
        api_domain: @api_domain
      }
    end
  end
end
