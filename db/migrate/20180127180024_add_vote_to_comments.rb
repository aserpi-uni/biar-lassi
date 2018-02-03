class AddVoteToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :vote, :boolean
  end
end
