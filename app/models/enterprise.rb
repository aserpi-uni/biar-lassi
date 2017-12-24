# The public profile of an enterprise.
# Only an Admin can create a new instance (and its first Employee, a supervisor).
# It is managed by the supervisors.
#
# *Parameters:*
# * +avatar+ [String]             url to the enterprise's avatar
# * +avatar_operator+ [String]    url of the default avatar for the operators
# * +avatar_supervisor+ [String]  url of the default avatar for the supervisors
# * +description+ [String]        small of description of the enterprise
# * +founded+ [Date]              the year the enterprise was founded
# * +headquarters+ [String]       headquarters of the enterprise
# * +name+ [String]               the name of the enterprise
# * +username_suffix+ [String]    the username suffix of its employee
# * +website+ [String]            enterprise's website
#
# *Associations:*
# * +has_many+ [Employee]         employees that work for the enterprise
class Enterprise < ApplicationRecord

  validates :avatar, format: { with: URI.regexp, message: I18n.t(:field_invalid) }, allow_blank: true

  validates :avatar_operator, format: { with: URI.regexp, message: I18n.t(:field_invalid) }, allow_blank: true

  validates :avatar_supervisor, format: { with: URI.regexp, message: I18n.t(:field_invalid) }, allow_blank: true

  validates :founded, numericality: { greater_than_or_equal_to: -4000, less_than_or_equal_to: 2500 }, allow_blank: true

  validates :name, format: { with: /\A[\w\s?!-]{3,64}\z/, message: I18n.t(:field_invalid) }, reserved_name: true,
                   uniqueness: { case_sensitive: false }

  validates :username_suffix, format: { with: /\A[\w\s?!-]{3,32}\z/, message: I18n.t(:field_invalid) }, reserved_name: true,
                              uniqueness: { case_sensitive: false }

  has_many :employees, dependent: :destroy
  has_many :products, dependent: :destroy

  # Deletes all Employees and products
  def soft_delete
    self.active = false
    save

    employees.each(&:soft_delete)
    products.each(&:soft_delete)
  end

  def to_param
    name
  end
end
