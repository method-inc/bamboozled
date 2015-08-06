require 'json'
require 'active_support/core_ext/hash/indifferent_access'

module Bamboozled
  module API
    class Base
      attr_reader :subdomain, :api_key

      def initialize(subdomain, api_key)
        @subdomain, @api_key = subdomain, api_key
      end

      protected
        def request(method, path, options = {})
          params = {
            path:    path,
            options: options,
            method:  method
          }

          httparty_options = {
            query:  options[:query],
            body:   options[:body],
            format: :plain,
            basic_auth: auth,
            headers: {
              "Accept"       => "application/json",
              "User-Agent"   => "Bamboozled/#{Bamboozled::VERSION}"
            }.update(options[:headers] || {})
          }

          response = HTTParty.send(method, "#{path_prefix}#{path}", httparty_options)
          params[:response] = response.inspect.to_s

          case response.code
          when 200..201
            begin
              if response.body.to_s.empty?
                {"headers" => response.headers, "code" => "200", "message" => "ok"}.with_indifferent_access
              else
                JSON.parse(response.body).with_indifferent_access
              end
            rescue
              MultiXml.parse(response, symbolize_keys: true)
            end
          when 400
            raise Bamboozled::BadRequest.new(response, params, 'The request was invalid or could not be understood by the server. Resubmitting the request will likely result in the same error.')
          when 401
            raise Bamboozled::AuthenticationFailed.new(response, params, 'Your API key is missing.')
          when 403
            raise Bamboozled::Forbidden.new(response, params, 'The application is attempting to perform an action it does not have privileges to access. Verify your API key belongs to an enabled user with the required permissions.')
          when 404
            raise Bamboozled::NotFound.new(response, params, 'The resource was not found with the given identifier. Either the URL given is not a valid API, or the ID of the object specified in the request is invalid.')
          when 406
            raise Bamboozled::NotAcceptable.new(response, params, 'The request contains references to non-existent fields.')
          when 409
            raise Bamboozled::Conflict.new(response, params, 'The request attempts to create a duplicate. For employees, duplicate emails are not allowed. For lists, duplicate values are not allowed.')
          when 429
            raise Bamboozled::LimitExceeded.new(response, params, 'The account has reached its employee limit. No additional employees could be added.')
          when 500
            raise Bamboozled::InternalServerError.new(response, params, 'The server encountered an error while processing your request and failed.')
          when 502
            raise Bamboozled::GatewayError.new(response, params, 'The load balancer or web server had trouble connecting to the Bamboo app. Please try the request again.')
          when 503
            raise Bamboozled::ServiceUnavailable.new(response, params, 'The service is temporarily unavailable. Please try the request again.')
          else
            raise Bamboozled::InformBamboo.new(response, params, 'An error occurred that we do not now how to handle. Please contact BambooHR.')
          end
        end

        def auth
          { username: api_key, password: "x" }
        end

        def path_prefix
          "https://api.bamboohr.com/api/gateway.php/#{subdomain}/v1/"
        end
    end
  end
end
