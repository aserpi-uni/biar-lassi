class AddConsumerToProblemThreads < ActiveRecord::Migration[5.1]
  def change
    add_reference :problem_threads, :consumer, foreign_key: true
  end
end
