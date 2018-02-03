class AddVotesToComment < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :votes, :integer, default: 0
  end
end
