# An admin of the website.
class Admin < ApplicationRecord
  devise :database_authenticatable,
         :lockable,
         :recoverable,
         :timeoutable,
         :trackable



  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: 'is invalid' },
                    user_uniqueness: true

  validates :username, uniqueness: { case_sensitive: false }, on: :create



  def to_param
    username
  end
end
