class EnterprisePolicy
  attr_reader :user, :enterprise

  def initialize(user, enterprise)
    @user = user
    @enterprise = enterprise
  end

  def create?
    @user.is_a? Admin
  end

  def update?
    @user.is_a?(Admin) ||
      (@user.is_a?(Employee) && @user.enterprise == @enterprise && @user.supervisor?)
  end
end
