class UniqueValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if Admin.find_by(attribute => value) ||
       Consumer.find_by(attribute => value) ||
       Employee.find_by(attribute => value)
      record.errors[attribute] << t(:already_used)
    end
  end
end
