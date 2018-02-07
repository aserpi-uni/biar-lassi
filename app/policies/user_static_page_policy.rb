class UserStaticPagePolicy < Struct.new(:user, :page)
  attr_reader :user

  def initialize(user, _page)
    @user = user
  end

  def advice_threads?
    consumer?
  end

  def consumer?
    @user.is_a?(Consumer)
  end

  def employee?
    @user.is_a?(Employee)
  end

  def problem_threads?
    consumer?
  end
end
