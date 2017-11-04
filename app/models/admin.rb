# An admin that can edit every resource.
# Only an Admin can create another admin. However, their profile is public.
#
# *Parameters:*
# * +username+ [String]  user public identification
# * +email+ [String]     user's email address
# * others               See https://github.com/plataformatec/devise
class Admin < ApplicationRecord
  devise :database_authenticatable,
         :lockable,
         :recoverable,
         :timeoutable,
         :trackable



  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: I18n.t(:field_invalid) },
                    user_uniqueness: true

  validates :username, format: { with: /\A\w{5,32}@admin\z/, message: I18n.t(:field_invalid) }, reserved_name: true,
                       uniqueness: { case_sensitive: false }, on: :create



  def to_param
    username
  end
end
