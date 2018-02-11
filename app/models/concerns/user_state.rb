# Utilities to soft delete and lock an user.
module UserState
  extend ActiveSupport::Concern

  # Soft deletes an user.
  def soft_delete
    self.email = nil
    self.locked_at = Time.now
    save validate: false
  end

  # Locks an user out of his account
  def soft_lock
    update locked_at: Time.now
  end

  # Manually unlocks an user
  def soft_unlock
    update locked_at: nil
  end
end
