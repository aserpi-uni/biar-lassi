class Admin < ApplicationRecord
  devise :database_authenticatable,
         :lockable,
         :recoverable,
         :timeoutable,
         :trackable

  validates :email, unique: true, on: :create
  validates :username, unique: true, on: :create

  def to_param
    username
  end
end
