module Bamboozled
  module API
    class Meta < Base

      # Public: Get a list of fields.
      # See https://www.bamboohr.com/api/documentation/metadata.php#getFields
      #
      # Returns an Array.
      def fields
        request(:get, "meta/fields")
      end

      # Public: Get the details for "list" fields in an account.
      # See https://www.bamboohr.com/api/documentation/metadata.php#getLists
      #
      # Returns an Array.
      def lists
        result = request(:get, "meta/lists")
        result[:lists][:list]
      end

      # Public: Get a list of tabular fields.
      # See https://www.bamboohr.com/api/documentation/metadata.php#getTables
      #
      # Returns an Array.
      def tables
        result = request(:get, "meta/tables")
        result[:tables][:table]
      end

      # Public: Get a list of users.
      # See https://www.bamboohr.com/api/documentation/metadata.php#getUsers
      #
      # Returns an Array.
      def users
        request(:get, "meta/users").values
      end
    end
  end
end
