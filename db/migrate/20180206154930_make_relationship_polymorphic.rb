class MakeRelationshipPolymorphic < ActiveRecord::Migration[5.1]
  def change
    add_column :relationships, :followed_type, :string
    rename_column :relationships, :follower_id, :consumer_id
  end
end
