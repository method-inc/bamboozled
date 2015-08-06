module Bamboozled
  module API
    class Tabular < Base
      def add_row(table_name: nil, columns: {}, employee_id: nil)
        url = "employees/#{employee_id}/tables/#{table_name}"
        row_data = generate_xml(columns)
        options = { body: row_data }

        request(:post, url, options)
      end

      private

      def generate_xml(columns)
        "".tap do |xml|
          xml << "<row>"
          columns.each { |k, v| xml << "<field id='#{k}'>#{v}</field>" }
          xml << "</row>"
        end
      end
    end
  end
end
