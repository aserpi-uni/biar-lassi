class RemoveVoteFromComment < ActiveRecord::Migration[5.1]
  def change
    remove_column :comments, :vote, :boolean
  end
end
