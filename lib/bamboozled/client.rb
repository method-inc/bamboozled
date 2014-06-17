module Bamboozled
  class Client
    include HTTParty
    base_uri 'api.bamboohr.com'

    def initialize(subdomain, api_key)
      @subdomain, @api_key = subdomain, api_key
    end

    def all_employees(fields = nil)
      fields = all_fields if fields.nil?
      r = request("employees/directory?fields=#{fields}")
      r['employees']
    end

    def employee(id, fields = nil)
      fields = all_fields if fields.nil?
      request("employees/#{id}?fields=#{fields}")
    end

    # Tabular data
    [:job_info, :employment_status, :compensation, :dependents, :contacts].each do |action|
      define_method("employee_#{action}") do |argument_id|
        request("employees/#{argument_id}/tables/#{action.to_s.gsub(/_(.)/) {|e| $1.upcase}}")
      end
    end

    # Reports
    def report(number, format = 'JSON', fd = true)
      request("reports/#{number}?format=#{format.upcase}&fd=#{fd.yesno}")
    end

    # def custom_report(options, format = 'JSON')
    #   post("reports/custom?format=#{format.upcase}", nil)
    # end

    # Time Off Requests
    def time_off_requests(options = {})
      allowed_parameters = [:id, :action, :employeeId, :start, :end, :type, :status]
      options = options.keep_if { |k,_| allowed_parameters.include? k }

      # Convert non string dates to strings.
      [:start, :end].each do |action|
        options[action] = options[action].strftime("%F") if options[action] && !options[action].is_a?(String)
      end

      # Make sure all statuses are allowed
      if options[:status]
        allowed_statuses = %w(approved denied superceded requested canceled)
        options[:status] = Array(options[:status]).keep_if { |v| allowed_statuses.include? v }.join(",")
      end

      request("time_off/requests?#{URI.encode_www_form(options)}")
    end

    def estimate_time_off(employee_id, end_date)
      end_date = end_date.strftime("%F") unless end_date.is_a?(String)
      request("employees/#{employee_id}/time_off/calculator?end=#{end_date}")
    end

    def whos_out(start_date, end_date = nil)
      start_date = start_date.strftime("%F") unless start_date.is_a?(String)
      end_date = end_date.strftime("%F") unless end_date.nil? || end_date.is_a?(String)
      request("time_off/whos_out?start=#{start_date}&end=#{end_date}")
    end

    def default_fields
      %w(displayName firstName lastName jobTitle workPhone mobilePhone workEmail department location photoUploaded photoUrl canUploadPhoto).join(',')
    end

    def all_fields
      %w(address1 address2 age bestEmail birthday city country dateOfBirth department division eeo employeeNumber employmentHistoryStatus ethnicity exempt firstName flsaCode fullName1 fullName2 fullName3 fullName4 fullName5 displayName gender hireDate homeEmail homePhone id jobTitle lastChanged lastName location maritalStatus middleName mobilePhone nickname payChangeReason payGroup payGroupId payRate payRateEffectiveDate payType ssn sin state stateCode status supervisor supervisorId supervisorEId terminationDate workEmail workPhone workPhonePlusExtension workPhoneExtension zipcode photoUploaded rehireDate standardHoursPerWeek bonusDate bonusAmount bonusReason bonusComment commissionDate commisionDate commissionAmount commissionComment).join(',')
    end

    private

    def request(path, fields = nil)
      fields = all_fields if fields.nil?
      self.class.get("#{path_prefix}#{path}", basic_auth: auth, headers: headers)
    end

    def post(path, data)
      self.class.post("#{path_prefix}#{path}", body: data, basic_auth: auth, headers: headers)
    end

    def headers
      { 'Accept' => 'application/json' }
    end

    def auth
      { username: @api_key, password: "x" }
    end

    def path_prefix
      "/api/gateway.php/#{@subdomain}/v1/"
    end

    # def self.get_all_stores
    #   get("/v1/stores")
    # end

    # def self.get_stores_by_zip(zip)
    #   get("/v1/stores(postalCode=#{zip})")
    # end

    # def self.get_stores_by_zip_and_distance(zip, distance)
    #   get("/v1/stores(area(#{zip},#{distance}))")
    # end

    # def self.get_product_by_sku(sku)
    #   get("/v1/products/#{sku}.xml")
    # end

    # def self.get_products(filter)
    #   response = get(URI.escape("/v1/products(#{filter})"))
    #   response["products"]["product"]
    # end

    # def self.method_missing(method_id, *args)
    #   if match = /get_products_by_([_a-zA-Z]\w*)/.match(method_id.to_s)
    #     attribute_names = match.captures.last.split('_and_')

    #     request = ""
    #     attribute_names.each_with_index { |name, idx| request = request + name + "=" + args[idx] + (attribute_names.length-1 == idx ? "" : "&") }

    #     get_products(request)
    #   else
    #     super
    #   end
    # end
  end
end
