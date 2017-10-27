class FacebookPolicy < Struct.new(:user, :facebook)
  attr_reader :user

  def initialize(user, facebook)
    @user = user
  end

  def connect_existing?
    !@user
  end

  def disconnect?
    @user.is_a?(Consumer) &&
      !@user.email.blank?
  end

  def facebook?
    !@user ||
      @user.is_a?(Consumer)
  end

  def select_username?
    !@user
  end

end
