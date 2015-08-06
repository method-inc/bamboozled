module Bamboozled
  module API
    class Tabular < Base
      require "pry"
      def add_row(table_name: nil, details: nil, employee_id: nil)
        url = "employees/#{employee_id}/tables/#{table_name}"
        row_data = generate_xml(details)
        options = { body: row_data }

        request(:post, url, options)
      end

      private

      def generate_xml(details)
        "".tap do |xml|
          xml << "<row>"
          details.each { |k, v| xml << "<field id='#{k}'>#{v}</field>" }
          xml << "</row>"
        end
      end
    end
  end
end
