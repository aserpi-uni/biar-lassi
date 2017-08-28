class RemoveRememberableFromEmployee < ActiveRecord::Migration[5.0]
  def change
    remove_column :employees, :remember_created_at, :datetime
  end
end
