module Bamboozled
  module API
    class Report < Base

      def find(number, format = 'JSON', fd_param = true)
        request(:get, "reports/#{number}?format=#{format.upcase}&fd=#{fd_param.yesno}")
      end

      # TODO - Implement custom reports
      # def custom(options, format = 'JSON')
      #   request(:post, "reports/custom?format=#{format.upcase}", data_should_go_here)
      # end
    end
  end
end
