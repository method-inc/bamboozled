module Bamboozled
  module API
    class TimeOff < Base

      def requests(options = {})
        allowed_parameters = [:id, :action, :employeeId, :start, :end, :type, :status]
        options = options.keep_if { |k,_| allowed_parameters.include? k }

        # Convert non string dates to strings.
        [:start, :end].each do |action|
          options[action] = options[action].strftime("%F") if options[action] && !options[action].is_a?(String)
        end

        # Make sure all statuses are allowed
        if options[:status]
          allowed_statuses = %w(approved denied superceded requested canceled)
          options[:status] = Array(options[:status]).keep_if { |v| allowed_statuses.include? v }.join(",")
        end

        request(:get, "time_off/requests?#{URI.encode_www_form(options)}")
      end

      def whos_out(start_date, end_date = nil)
        start_date = start_date.strftime("%F") unless start_date.is_a?(String)
        end_date = end_date.strftime("%F") unless end_date.nil? || end_date.is_a?(String)
        request(:get, "time_off/whos_out?start=#{start_date}&end=#{end_date}")
      end
    end
  end
end
