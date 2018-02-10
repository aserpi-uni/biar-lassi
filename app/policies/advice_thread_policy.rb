class AdviceThreadPolicy < ApplicationPolicy
  attr_reader :user, :advice_thread

  def initialize(user, advice_thread)
    @user = user
    @advice_thread = advice_thread
  end

  def index?
    show?
  end

  def show?
    !@user.is_a?(Employee) ||
      @user.enterprise == @advice_thread.product.enterprise
  end

  def create?
    @user.is_a?(Consumer) && @advice_thread.product.active
  end

  def update?
    (@user.is_a?(Admin) ||
      @user == @advice_thread.author ||
      (@user.is_a?(Employee) && @user.same_enterprise?(@advice_thread) && @user.supervisor?)) &&
      @advice_thread.product.active
  end

  def follow?
    @user.is_a?(Consumer)
  end

  def down?
    (@user.is_a?(Consumer) || (@user.is_a?(Employee) && @user.same_enterprise?(@advice_thread))) &&
      @user != @advice_thread.author &&
      @advice_thread.down_votes.where(downer: @user).empty?
  end

  def down_votes?
    show?
  end

  def search?
    show?
  end

  def up?
    (@user.is_a?(Consumer) || (@user.is_a?(Employee) && @user.same_enterprise?(@advice_thread))) &&
      @user != @advice_thread.author &&
      @advice_thread.up_votes.where(upper: @user).empty?
  end

  def permitted_attributes
    if @user.is_a?(Employee)
      %i[status]
    else
      %i[content title]
    end
  end

  class Scope < Scope
    def resolve
      if @user.is_a? Employee
        scope.joins(:product).where('products.enterprise_id' => @user.enterprise.id)
      else
        scope.all
      end
    end
  end
end
