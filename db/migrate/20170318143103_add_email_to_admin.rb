class AddEmailToAdmin < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :email, :string

    add_index :admins, :email, unique: true, length: 191
  end
end
