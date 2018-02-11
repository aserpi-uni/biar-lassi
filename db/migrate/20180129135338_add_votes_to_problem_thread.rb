class AddVotesToProblemThread < ActiveRecord::Migration[5.1]
  def change
    add_column :problem_threads, :votes, :integer, default: 0
  end
end
