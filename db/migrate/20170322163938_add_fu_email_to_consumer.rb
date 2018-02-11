class AddFuEmailToConsumer < ActiveRecord::Migration[5.1]
  def change
    add_column :consumers, :email, :string
    add_index :consumers, :email, unique: true, length: 191
  end
end
