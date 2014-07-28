module Bamboozled
  module API
    class Employee < Base

      def all(fields = nil)
        response = request(:get, "employees/directory")

        if fields.nil? || fields == :default
          Array(response['employees'])
        else
          employees = []
          response['employees'].map{|e| e['id']}.each do |id|
            employees << find(id, fields)
          end
          employees
        end
      end

      def find(id, fields = nil)
        fields = all_fields if fields == :all
        fields = fields.join(',') if fields.is_a?(Array)

        request(:get, "employees/#{id}?fields=#{fields}")
      end

      # Tabular data
      [:job_info, :employment_status, :compensation, :dependents, :contacts].each do |action|
        define_method(action.to_s) do |argument_id|
          request(:get, "employees/#{argument_id}/tables/#{action.to_s.gsub(/_(.)/) {|e| $1.upcase}}")
        end
      end

      def time_off_estimate(id, end_date)
        end_date = end_date.strftime("%F") unless end_date.is_a?(String)
        request(:get, "employees/#{id}/time_off/calculator?end=#{end_date}")
      end

      def all_fields
        %w(address1 address2 age bestEmail birthday city country dateOfBirth department division eeo employeeNumber employmentHistoryStatus ethnicity exempt firstName flsaCode fullName1 fullName2 fullName3 fullName4 fullName5 displayName gender hireDate homeEmail homePhone id jobTitle lastChanged lastName location maritalStatus middleName mobilePhone nickname payChangeReason payGroup payGroupId payRate payRateEffectiveDate payType ssn sin state stateCode status supervisor supervisorId supervisorEId terminationDate workEmail workPhone workPhonePlusExtension workPhoneExtension zipcode photoUploaded rehireDate standardHoursPerWeek bonusDate bonusAmount bonusReason bonusComment commissionDate commisionDate commissionAmount commissionComment).join(',')
      end
    end
  end
end
