class AddTimestampsToDownVote < ActiveRecord::Migration[5.1]
  def change
    add_timestamps :down_votes
  end
end
