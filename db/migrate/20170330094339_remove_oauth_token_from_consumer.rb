class RemoveOauthTokenFromConsumer < ActiveRecord::Migration[5.0]
  def change
    remove_column :consumers, :oauth_token, :string
    remove_column :consumers, :oauth_expires_at, :datetime
  end
end
