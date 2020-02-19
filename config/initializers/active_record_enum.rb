module ActiveRecord
  module Enum
    class EnumType < Type::Value
      def assert_valid_value(value)
        unless value.blank? || mapping.key?(value) || mapping.value?(value)
          nil
        end
      end
    end
  end
end
