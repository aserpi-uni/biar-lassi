# Checks if the resource is active.
class ActiveValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << I18n.t(:must_be_active) unless value&.active
  end
end
