class Admin < ApplicationRecord
  devise :database_authenticatable,
         :confirmable,
         :lockable,
         :recoverable,
         :rememberable,
         :registerable,
         :timeoutable,
         :trackable,
         :validatable

  validates :email, unique: true, on: :create
  validates :username, unique: true, on: :create

  def to_param
    username
  end
end
