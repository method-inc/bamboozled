module Bamboozled
  module API
    class TimeTracking < Base
      def record(time_tracking_id)
        request(:get, "timetracking/record/#{time_tracking_id}")
      end

      def add(time_tracking_details)
        # details = generate_xml(time_tracking_details)
        details = time_tracking_details.to_json
        options = { body: details }

        request(:post, "timetracking/add/", options)
      end

      def adjust(time_tracking_id, hours_worked)
        details = { timeTrackingId: time_tracking_id, hoursWorked: hours_worked }.to_json
        options = { body: details }

        request(:put, "timetracking/adjust", options)
      end
    end
  end
end
