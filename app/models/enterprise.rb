# The public profile of an enterprise.
# Only an Admin can create a new instance (and its first Employee, a supervisor).
# It is managed by the supervisors.
#
# *Parameters:*
# * +avatar+ [String]             url to the enterprise's avatar
# * +avatar_operator+ [String]    TODO: remove
# * +avatar_supervisor+ [String]  TODO: remove
# * +description+ [String]        small of description of the enterprise
# * +founded+ [Date]              the year the enterprise was founded
# * +headquarters+ [String]       headquarters of the enterprise
# * +icon+ [String]               TODO: remove
# * +name+ [String]               the name of the enterprise
# * +username_suffix+ [String]    the username suffix of its employee
# * +website+ [String]            enterprise's website
#
# *Associations:*
# * +has_many+ [Employee]         employees that work for the enterprise
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
