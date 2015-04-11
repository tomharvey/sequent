require 'active_model'

module Sequent
  module Core
    module Helpers
      # Validates Dates
      # Automatically included when using a
      #
      #   attrs value: Date
      class DateValidator < ActiveModel::EachValidator
        def validate_each(subject, attribute, value)
          subject.errors.add attribute, :invalid_date unless Date.valid_value?(value)
        end
      end
      # Validates DateTimes
      # Automatically included when using a
      #
      #   attrs value: DateTime
      class DateTimeValidator < ActiveModel::EachValidator
        def validate_each(subject, attribute, value)
          return if value.is_a?(DateTime)
          begin
            DateTime.deserialize_from_json(value)
          rescue
            subject.errors.add attribute, :invalid_date_time
          end
        end
      end
    end
  end
end
