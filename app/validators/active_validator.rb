# Checks if the value is included in the reserved names list.
class ActiveValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << I18n.t(:must_be_active) unless value&.active
  end
end
