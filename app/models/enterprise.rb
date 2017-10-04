class Enterprise < ApplicationRecord
  # TODO: validations

  has_many :employees

  def to_param
    name
  end
end
