module Bamboozled
  class HTTPError < StandardError
    attr_reader :response
    attr_reader :params
    attr_reader :hint

    def initialize(response, params = {}, hint = nil)
      @response = response
      @params = params
      @hint = hint
      super(response)
    end

    def to_s
      "#{self.class} : #{response.code} #{response.body}".tap do |msg|
        msg << "\n#{hint}" if hint
      end
    end
  end

  class BadRequest < HTTPError; end
  class Unauthorized < HTTPError; end
  class AuthenticationFailed < HTTPError; end
  class Forbidden < HTTPError; end
  class NotFound < HTTPError; end
  class NotAcceptable < HTTPError; end
  class Conflict < HTTPError; end
  class LimitExceeded < HTTPError; end
  class InternalServerError < HTTPError; end
  class GatewayError < HTTPError; end
  class ServiceUnavailable < HTTPError; end
  class InformBamboo < HTTPError; end
end
