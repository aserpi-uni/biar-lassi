# An employee of an Enterprise. Manages relations with Consumers.
#
# Types:
# * *Operator*:    the normal kind, manages open tickets and suggestions
# * *Supervisor*:  a chief, is responsible of the enterprise and its employees
#
# *Parameters:*
# * +username+ [String]  user public identification
# * +email+ [String]     user's email address
# * others               See https://github.com/plataformatec/devise
#
# *Associations:*
# * +belongs_to+ [Enterprise]  enterprise for which they work
class Employee < ApplicationRecord
  include UserState

  devise :database_authenticatable,
         :lockable,
         :recoverable,
         :timeoutable,
         :trackable

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i,
                              message: I18n.t(:field_invalid) },
                    user_uniqueness: true

  validates :password, confirmation: true, length: { in: 8..128 }, on: :create
  validates :password, confirmation: true, length: { in: 8..128 }, allow_blank: true, on: :update

  validates :username, format: { with: /\A\w{5,32}@\w{1,32}\z/, message: I18n.t(:field_invalid) }, reserved_name: true,
                       uniqueness: { case_sensitive: false }, on: :create

  enum role: { supervisor: 0, operator: 1 }

  belongs_to :enterprise

  def update(attributes)
    old_role = role
    res = super attributes

    reallocate_tickets if res && old_role == 'operator' && role != 'operator'

    res
  end

  # Create a new Employee from +create+ action parameters.
  def self.from_params(params)
    employee = Employee.new
    params[:password] = params[:password_confirmation] = Devise.friendly_token(20)

    if (params[:enterprise] = Enterprise.find_by(name: params[:enterprise])) && params[:enterprise].active?
      params[:username] = "#{params[:username]}@#{params[:enterprise].username_suffix}"
    else
      params[:username] = "#{params[:username]}@no_enterprise"
    end

    employee.assign_attributes(params)

    employee

    #
    # employee = Employee.new
    # pwd = Devise.friendly_token(20)
    #
    # employee.email = params[:email]
    # if (employee.enterprise = Enterprise.find_by(name: params[:enterprise])) && employee.enterprise.active?
    #   employee.username = "#{params[:username]}@#{employee.enterprise.username_suffix}"
    # else
    #   employee.username = "#{params[:username]}@no_enterprise"
    # end
    # employee.role = params[:role]
    #
    # employee.password = pwd
    # employee.password_confirmation = pwd
    #
    # employee
  end

  def reallocate_tickets
    # TODO: redistribuire ogni ticket aperto ad altri operator
  end

  # Updates the Employee's suffix with the newest one
  def update_suffix
    self.username = "#{username[/(^[^@]*)/]}@#{enterprise.username_suffix}"
    save
  end

  def to_param
    username
  end
end
