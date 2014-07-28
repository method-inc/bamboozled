module Bamboozled
  module API
    class Meta < Base

      [:field, :table, :list, :user].each do |action|
        define_method("#{action}s") do
          result = request(:get, "meta/#{action}s")
          result["#{action}s".to_sym][action]
        end
      end

    end
  end
end
