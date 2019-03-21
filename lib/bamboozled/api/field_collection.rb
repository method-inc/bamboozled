module Bamboozled
  module API
    class FieldCollection
      def self.wrap(fields)
        fields = all_names if fields == :all
        fields = fields.split(",") if fields.is_a?(String)
        new(fields)
      end

      def self.all_names # rubocop:disable Metrics/MethodLength
        %w[
          address1
          address2
          age
          bestEmail
          birthday
          bonusAmount
          bonusComment
          bonusDate
          bonusReason
          city
          commisionDate
          commissionAmount
          commissionComment
          commissionDate
          country
          dateOfBirth
          department
          displayName
          division
          eeo
          employeeNumber
          employmentHistoryStatus
          ethnicity
          exempt
          firstName
          flsaCode
          fullName1
          fullName2
          fullName3
          fullName4
          fullName5
          gender
          hireDate
          homeEmail
          homePhone
          id
          includeInPayroll
          isPhotoUploaded
          jobTitle
          lastChanged
          lastName
          location
          maritalStatus
          middleName
          mobilePhone
          originalHireDate
          paidPer
          payChangeReason
          payFrequency
          payGroup
          payGroupId
          payPer
          payRate
          payRateEffectiveDate
          paySchedule
          payScheduleId
          payType
          preferredName
          sin
          ssn
          standardHoursPerWeek
          state
          stateCode
          status
          supervisor
          supervisorEId
          supervisorId
          terminationDate
          workEmail
          workPhone
          workPhoneExtension
          workPhonePlusExtension
          zipcode
        ]
      end

      def initialize(fields)
        self.fields = fields || []
      end

      def to_csv
        fields.join(",")
      end

      def to_xml
        "<fields>" +
          fields.map { |field| "<field id=\"#{field}\" />" }.join +
          "</fields>"
      end

      private

      attr_accessor :fields
    end
  end
end
