# Checks if the value is included in the reserved names list.
class ReservedNameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << I18n.t(:already_used) if ENV['RESERVED_NAMES'].tr('"', ' ').split.include?(value)
  end
end
