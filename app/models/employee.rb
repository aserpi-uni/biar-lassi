class Employee < ApplicationRecord
  devise :database_authenticatable,
         :lockable,
         :recoverable,
         :timeoutable,
         :trackable

  enum role: { supervisor: 0, operator: 1 }

  belongs_to :enterprise

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: 'is invalid' },
            unique: { global: true }, on: :create
  validates :password, confirmation: true, length: { in: 8..128 }, on: :create
  validates :username, format: { with: /\A\w{5,32}@\w{1,32}\z/, message: 'is invalid' }, reserved_name: true,
            unique: { global: false }, on: :create

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: 'is invalid' },
            allow_blank: true, on: :update
  validates :password, confirmation: true, length: { in: 8..128 }, allow_blank: true, on: :update

  def self.create_new(params)
    employee = Employee.new
    employee.email = params[:email]
    employee.enterprise = params[:enterprise]
    employee.username = "#{params[:username]}@#{employee.enterprise.nickname_suffix}"
    employee.role = params[:role]
    employee.password = params[:password]
    employee.password_confirmation = params[:password_confirmation]

    employee
  end

  def to_param
    username
  end
end
