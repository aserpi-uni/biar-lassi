# An employee of an Enterprise. Manages relations with Consumers.
#
# Types:
# * *Operator*:    the normal kind, manages open tickets and suggestions
# * *Supervisor*:  a chief, is responsible of the enterprise and its employees
#
# *Parameters:*
# * +username+ [String]   user public identification
# * +email+ [String]      user's email address
# * +role+ [Type]         employee's role in his enterprise
# * others                See https://github.com/plataformatec/devise
#
# *Associations:*
# * +belongs_to+ [Enterprise]     enterprise for which they work
# * +has_many+ [Comment]          comments posted by the employee
# * +has_many+ [DownVote]         negative votes posted by the user
# * +has_many+ [ProblemThread]    problem threads assigned to the employee (only if it is an operator)
# * +has_many+ [UpVote]           positive votes posted by the user
class Employee < ApplicationRecord
  include UserState

  devise :database_authenticatable,
         :lockable,
         :recoverable,
         :timeoutable,
         :trackable

  enum role: { supervisor: 0, operator: 1 }

  belongs_to :enterprise

  has_many :comments, as: :author, dependent: :destroy
  has_many :down_votes, as: :downer, dependent: :destroy
  has_many :problem_threads
  has_many :up_votes, as: :upper, dependent: :destroy

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }, user_uniqueness: true

  validates :enterprise, active: true

  validates :password, confirmation: true, length: { in: 8..128 }, on: :create
  validates :password, confirmation: true, length: { in: 8..128 }, allow_blank: true, on: :update

  validates :username, format: { with: /\A\w{5,32}@\w{1,32}\z/ }, reserved_name: true,
                       uniqueness: { case_sensitive: false }, on: :create

  # Create a new Employee from +create+ action parameters.
  def self.from_params(params)
    employee = Employee.new

    params[:enterprise] = Enterprise.where(name: params[:enterprise]).first
    params[:password] = params[:password_confirmation] = Devise.friendly_token(20)
    params[:username] = "#{params[:username]}@#{if params[:enterprise]&.active
                                                  params[:enterprise]&.username_suffix
                                                else
                                                  'invalid_enterprise'
                                                end}"

    employee.assign_attributes(params)

    employee
  end

  def update(attributes)
    old_role = role
    res = super attributes

    reallocate_tickets if res && old_role == 'operator' && role != 'operator'

    res
  end

  def reallocate_tickets
    problem_threads.each do |thread|
      thread.update(employee: thread.product.assign_operator_problem_thread)
    end
  end

  def soft_delete
    super
    reallocate_tickets
  end

  def same_enterprise?(resource)
    if resource.is_a? DownVote
      resource = resource.downable
    elsif resource.is_a? UpVote
      resource = resource.uppable
    end
    return resource.problem_thread.product.enterprise == enterprise if resource.is_a?(Comment)
    return resource.product.enterprise == enterprise if resource.is_a?(ProblemThread)
    return resource.enterprise == enterprise if resource.is_a?(Product)
    return resource == enterprise if resource.is_a?(Enterprise)
    false
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
