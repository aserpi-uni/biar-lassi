class AddProblemThreadToComments < ActiveRecord::Migration[5.1]
  def change
    add_reference :comments, :problem_thread, foreign_key: true
  end
end
