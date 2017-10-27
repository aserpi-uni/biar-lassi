class GlobalUniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    found = Admin.find_by(attribute => value) || Consumer.find_by(attribute => value) || Employee.find_by(attribute => value)
    record.errors[attribute] << I18n.t(:already_used) if !found.nil? && record != found
  end
end
