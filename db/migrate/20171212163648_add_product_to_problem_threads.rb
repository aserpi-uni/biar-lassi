class AddProductToProblemThreads < ActiveRecord::Migration[5.1]
  def change
    add_reference :problem_threads, :product, foreign_key: true
  end
end
