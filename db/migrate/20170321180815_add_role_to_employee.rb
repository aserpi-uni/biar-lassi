class AddRoleToEmployee < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :role, :integer, default: 0
  end
end
