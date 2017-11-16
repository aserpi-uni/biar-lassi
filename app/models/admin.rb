# An admin that can edit every resource.
# Only an Admin can create another admin. However, their profile is public.
#
# *Parameters:*
# * +username+ [String]  user public identification
# * +email+ [String]     user's email address
# * others               See https://github.com/plataformatec/devise
class Admin < ApplicationRecord
  include UserState

  devise :database_authenticatable,
         :lockable,
         :recoverable,
         :timeoutable,
         :trackable



  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: I18n.t(:field_invalid) },
                    user_uniqueness: true

  validates :password, confirmation: true, length: { in: 8..128 }, on: :create
  validates :password, confirmation: true, length: { in: 8..128 }, allow_blank: true, on: :update

  validates :username, format: { with: /\A\w{5,32}@admin\z/, message: I18n.t(:field_invalid) }, reserved_name: true,
                       uniqueness: { case_sensitive: false }, on: :create



  # Create a new Admin from +create+ action parameters.
  def self.from_params(params)
    admin = Admin.new
    pwd = Devise.friendly_token 20

    admin.username = "#{params[:username]}@admin"
    admin.email = params[:email]
    admin.password = pwd
    admin.password_confirmation = pwd

    admin
  end


  def to_param
    username
  end
end
