class Employee < ApplicationRecord
  devise :database_authenticatable,
         :lockable,
         :recoverable,
         :timeoutable,
         :trackable

  enum role: { supervisor: 0, operator: 1 }

  validates :email, unique: true, on: :create
  validates :username, unique: true, on: :create

  def to_param
    username
  end
end
