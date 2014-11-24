module Bamboozled
  module API
    class Meta < Base

      [:field, :table, :list, :user].each do |action|
        define_method(action.to_s}+"s") do
          request(:get, "meta/#{action}s", {:tabular => true})
        end
      end

    end
  end
end
