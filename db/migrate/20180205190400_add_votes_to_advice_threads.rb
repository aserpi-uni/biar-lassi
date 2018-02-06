class AddVotesToAdviceThreads < ActiveRecord::Migration[5.1]
  def change
    add_column :advice_threads, :votes, :integer, default: 0
  end
end
