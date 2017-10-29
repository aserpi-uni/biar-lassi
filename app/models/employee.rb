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
  devise :database_authenticatable,
         :lockable,
         :recoverable,
         :timeoutable,
         :trackable



  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: 'is invalid' },
                    user_uniqueness: true

  validates :password, confirmation: true, length: { in: 8..128 }, on: :create
  validates :password, confirmation: true, length: { in: 8..128 }, allow_blank: true, on: :update

  validates :username, format: { with: /\A\w{5,32}@\w{1,32}\z/, message: 'is invalid' }, reserved_name: true,
                       uniqueness: { case_sensitive: false }, on: :create

  enum role: { supervisor: 0, operator: 1 }

  belongs_to :enterprise


  # Create a new Employee from +create+ action parameters.
  def self.create_new(params)
    employee = Employee.new
    employee.email = params[:email]
    if (employee.enterprise = Enterprise.find_by(name: params[:enterprise]))
      employee.username = "#{params[:username]}@#{employee.enterprise.username_suffix}"
    else
      employee.username = "#{params[:username]}@no_enterprise"
    end
    employee.role = params[:role]
    employee.password = params[:password]
    employee.password_confirmation = params[:password_confirmation]

    employee
  end

  def update_suffix
    self.username = "#{username[/(^[^@]*)/]}@#{enterprise.username_suffix}"
    save
  end

  def to_param
    username
  end
end
