class UniqueValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if Admin.find_by(attribute => value) or
        Consumer.find_by(attribute => value) or
        Employee.find_by(attribute => value)
      record.errors[attribute] << 'already used'
    end
  end
end
