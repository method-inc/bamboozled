module Bamboozled
  module API
    class Report < Base

      def find(number, format = "JSON", fd_param = true)
        request(:get, "reports/#{number}?format=#{format.upcase}&fd=#{fd_param.yesno}")
      end

      def custom(fields, hide_null = false, date = nil, format = "JSON")
        options = {
          body: "<report>#{filters_xml(hide_null, date)}#{fields_xml(fields)}</report>"
        }

        response = request(:post, "reports/custom?format=#{format.upcase}", options)
        response["employees"]

      end

      private

      def filters_xml(hide_null, date)
        filters = null_filter(hide_null) + date_filter(date)
        return if filters.empty?

        "<filters><lastChanged>#{filters}</lastChanged></filters>"
      end

      def null_filter(hide_null)
        return '' unless hide_null == true

        '<includeNull>no</includeNull>'
      end

      def date_filter(date)
        return '' if date.nil?

        "<value>#{date.to_iso8601}</value>"
      end

      def fields_xml(fields)
        FieldCollection.wrap(fields).to_xml
      end
    end
  end
end
