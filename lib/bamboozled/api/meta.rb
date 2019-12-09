module Bamboozled
  module API
    class Meta < Base
      def users
        request(:get, "meta/users").values
      end

      def fields
        request(:get, "meta/fields")
      end

      def lists
        request(:get, "meta/lists")
      end

      def tables
        request(
          :get, "meta/tables",
          typecast_values: false)
      end

    end
  end
end
