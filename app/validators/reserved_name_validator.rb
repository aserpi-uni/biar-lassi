class ReservedNameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << I18n.t(:already_used) if ENV['RESERVED_NAMES'].split.any? {|s| s.casecmp(value).zero?}
  end
end
