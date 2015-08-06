module Bamboozled
  class Base
    attr_reader :request

    def initialize(subdomain: nil, api_key: nil)
      @subdomain, @api_key = subdomain, api_key
    end

    def employee
      @employee ||= Bamboozled::API::Employee.new(@subdomain, @api_key)
    end

    def report
      @report ||= Bamboozled::API::Report.new(@subdomain, @api_key)
    end

    def meta
      @meta ||= Bamboozled::API::Meta.new(@subdomain, @api_key)
    end

    def time_off
      @time_off ||= Bamboozled::API::TimeOff.new(@subdomain, @api_key)
    end

    def tabular
      @tabular ||= Bamboozled::API::Tabular.new(@subdomain, @api_key)
    end
  end
end
