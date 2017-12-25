# Policy enforced in Devise controllers.
class DevisePolicy < Struct.new(:user, :devise)
  attr_reader :user

  def initialize(user, _devise)
    @user = user
  end

  def standard
    !@user
  end
end
