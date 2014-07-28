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
      "#{self.class.to_s} : #{response.code} #{response.body}" + (hint ? "\n#{hint}" : "")
    end
  end

  class BadRequest < HTTPError; end #400
  class Unauthorized < HTTPError ; end #
  class Forbidden < HTTPError ; end # 403
  class NotFound < HTTPError; end # 404
  class NotAcceptable < HTTPError; end # 406
  class Conflict < HTTPError; end # 409
  class LimitExceeded < HTTPError; end # 429
  class InternalServerError < HTTPError; end # 500
  class GatewayError < HTTPError; end # 502
  class ServiceUnavailable < HTTPError; end # 503
  class InformBamboo < HTTPError; end
end
