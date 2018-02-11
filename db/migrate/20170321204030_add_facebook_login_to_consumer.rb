class AddFacebookLoginToConsumer < ActiveRecord::Migration[5.1]
  def change
    add_column :consumers, :provider, :string
    add_column :consumers, :uid, :string
    add_column :consumers, :oauth_token, :string
    add_column :consumers, :oauth_expires_at, :datetime

    add_index :consumers, :uid, length: 191
  end
end
