class Employee < ApplicationRecord
  devise :database_authenticatable,
         :lockable,
         :recoverable,
         :rememberable,
         :registerable,
         :trackable,
         :validatable

  enum role: {supervisor: 0, analyst: 1, operator: 2}

  validates :email, unique: true
  validates :username, unique: true

  def to_param
    username
  end
end
