class DevisePolicy < Struct.new(:user, :devise)
  attr_reader :user

  def initialize(user, devise)
    @user = user
  end

  def standard
    !@user
  end
end
