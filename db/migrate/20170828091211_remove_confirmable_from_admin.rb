class RemoveConfirmableFromAdmin < ActiveRecord::Migration[5.1]
  def change
    remove_column :admins, :confirmation_token, :string
    remove_column :admins, :confirmed_at, :datetime
    remove_column :admins, :confirmation_sent_at, :datetime
  end
end
