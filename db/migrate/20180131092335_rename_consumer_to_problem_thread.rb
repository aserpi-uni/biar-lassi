class RenameConsumerToProblemThread < ActiveRecord::Migration[5.1]
  def change
    rename_column :problem_threads, :consumer_id, :author_id
  end
end
