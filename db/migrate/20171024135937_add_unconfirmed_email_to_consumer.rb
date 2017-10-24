class AddUnconfirmedEmailToConsumer < ActiveRecord::Migration[5.1]
  def change
    add_column :consumers, :unconfirmed_email, :text
  end
end
