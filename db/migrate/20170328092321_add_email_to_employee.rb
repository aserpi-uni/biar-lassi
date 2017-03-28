class AddEmailToEmployee < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :email, :string
    add_index :employees, :email, unique: true, length: 191
  end
end
