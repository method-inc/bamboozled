module Bamboozled
  module API
    class Employee < Base
      def all(fields = nil)
        response = request(:get, "employees/directory")

        if fields.nil? || fields == :default
          Array(response["employees"])
        else
          response["employees"].collect { |e| find(e["id"], fields) }
        end
      end

      def find(employee_id, fields = nil)
        fields = all_fields if fields == :all
        fields = fields.join(",") if fields.is_a?(Array)

        request(:get, "employees/#{employee_id}?fields=#{fields}")
      end

      # Tabular data
      actions = %w(jobInfo employment_status compensation dependents contacts)
      actions.each do |action|
        method_name = ActiveSupport::Inflector.underscore(action)
        define_method(method_name) do |argument_id|
          request(:get, "employees/#{argument_id}/tables/#{action}")
        end
      end

      def time_off_estimate(employee_id, end_date)
        end_date = end_date.strftime("%F") unless end_date.is_a?(String)
        uri = "employees/#{employee_id}/time_off/calculator?end=#{end_date}"
        request(:get, uri)
      end

      def all_fields
        %w(address1 address2 age bestEmail birthday city country dateOfBirth
           department division eeo employeeNumber employmentHistoryStatus
           ethnicity exempt firstName flsaCode fullName1 fullName2 fullName3
           fullName4 fullName5 displayName gender hireDate homeEmail homePhone
           id jobTitle lastChanged lastName location maritalStatus middleName
           mobilePhone nickname payChangeReason payGroup payGroupId payRate
           payRateEffectiveDate payType ssn sin state stateCode status
           supervisor supervisorId supervisorEId terminationDate workEmail
           workPhone workPhonePlusExtension workPhoneExtension zipcode
           photoUploaded rehireDate standardHoursPerWeek bonusDate bonusAmount
           bonusReason bonusComment commissionDate commisionDate
           commissionAmount commissionComment
        ).join(",")
      end

      def photo_binary(employee_id)
        request(:get, "employees/#{employee_id}/photo/small")
      end

      def photo_url(employee)
        begin
          employee_id = Float(employee)
        rescue
          false
        end

        if employee_id
          e = find(employee, %w(workEmail homeEmail))
          employee = e["workEmail"].nil? ? e["homeEmail"] : e["workEmail"]
        end

        digest = Digest::MD5.new
        digest.update(employee.strip.downcase)
        "http://#{@subdomain}.bamboohr.com/employees/photos/?h=#{digest}"
      end

      def add(employee_details)
        details = generate_xml(employee_details)
        options = { body: details }

        request(:post, "employees/", options)
      end

      def update(bamboo_id, employee_details)
        details = generate_xml(employee_details)
        options = { body: details }

        request(:post, "employees/#{bamboo_id}", options)
      end

      private

      def generate_xml(employee_details)
        "".tap do |xml|
          xml << "<employee>"

          employee_details.each do |k, v|
            xml << "<field id='#{k}'>#{v}</field>"
          end

          xml << "</employee>"
        end
      end
    end
  end
end
