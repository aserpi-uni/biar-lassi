class Enterprise < ApplicationRecord

  validates :name, format: { with: /\A[\w\s?!-]{3,64}\z/, message: 'is invalid' }, reserved_name: true,
            uniqueness: { case_sensitive: false }, on: :create

  validates :username_suffix, format: { with: /\A[\w\s?!-]{3,32}\z/, message: 'is invalid' }, reserved_name: true,
            uniqueness: { case_sensitive: false }, on: :create

  has_many :employees

  def to_param
    name
  end
end
