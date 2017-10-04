class UniqueValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if (options.key?(:global) && options[:global]) &&
       (Admin.find_by(attribute => value) ||
       Consumer.find_by(attribute => value) ||
       Employee.find_by(attribute => value))
      record.errors[attribute] << I18n.t(:already_used)
    elsif record.class.find_by(attribute => value)
      record.errors[attribute] << I18n.t(:already_used)
    end
  end
end
