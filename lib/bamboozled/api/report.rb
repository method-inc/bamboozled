module Bamboozled
  module API
    class Report < Base

      def find(number, format = "JSON", fd_param = true)
        request(:get, "reports/#{number}?format=#{format.upcase}&fd=#{fd_param.yesno}")
      end

      def custom(fields, include_null = true ,date = nil,  format='JSON' )
        url = URI("#{path_prefix}reports/custom?format=#{format.upcase}")
        puts url
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        request = Net::HTTP::Post.new(url)
        request["content-type"] = 'application/json'
        request.basic_auth auth[:username], auth[:password]
        request.body = body(fields, include_null, date).to_json
        response = http.request(request)
        response.read_body
      end

      private

      def body(fields, include_null, date)
        body = {}
        body[:fields] = fields || FieldCollection.all_names
        last_changed_object = {}
        last_changed_object[:includeNull] = include_null.to_s
        last_changed_object[:value] = date

        body[:filters] = { lastChanged: last_changed_object }
        body
      end
    end
  end
end
