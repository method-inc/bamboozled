module Bamboozled
  module API
    class Report < Base

      def find(number, format = 'JSON', fd_param = true)
        request(:get, "reports/#{number}?format=#{format.upcase}&fd=#{fd_param.yesno}")
      end

      def custom(fields, format = 'JSON')
        options = {
          body: "<report>#{FieldCollection.wrap(fields).to_xml}</report>"
        }

        response = request(:post, "reports/custom?format=#{format.upcase}", options)
        response["employees"]
      end
    end
  end
end
