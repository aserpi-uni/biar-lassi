class EnterprisePolicy
  attr_reader :user, :enterprise

  def initialize(user, enterprise)
    @user = user
    @enterprise = enterprise
  end

  def new?
    @user.is_a? Admin
  end

  def create?
    @user.is_a? Admin
  end
end
