module Bamboozled
  module API
    class LastChangedFilter
      def self.to_xml(hide_null, last_changed_filter)
        new(hide_null, last_changed_filter).send(:filters_to_xml)
      end

      private

      attr_accessor :hide_null, :last_changed_filter

      def initialize(hide_null, last_changed_filter)
        @hide_null = hide_null
        @last_changed_filter = last_changed_filter
      end

      def filters_to_xml
        filters = null_filter(hide_null) + date_filter(date)
        return if filters.empty?

        "<filters><lastChanged>#{filters}</lastChanged></filters>"
      end

      def null_filter
        return "" unless hide_null == true

        "<includeNull>no</includeNull>"
      end

      def date_filter
        return "" if date.nil?

        "<value>#{date.to_iso8601}</value>"
      end

      def fields_xml
        FieldCollection.wrap(fields).to_xml
      end
    end
  end
end
