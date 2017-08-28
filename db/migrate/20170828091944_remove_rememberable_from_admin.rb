class RemoveRememberableFromAdmin < ActiveRecord::Migration[5.0]
  def change
    remove_column :admins, :remember_created_at, :datetime
  end
end
