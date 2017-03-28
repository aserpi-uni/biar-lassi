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

  validates :email, unique: true
  validates :username, unique: true

  def to_param
    username
  end
end
