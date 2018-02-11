class AddEmployeeToProblemThreads < ActiveRecord::Migration[5.1]
  def change
    add_reference :problem_threads, :employee, foreign_key: true
  end
end
