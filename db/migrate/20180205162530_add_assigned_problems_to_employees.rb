class AddAssignedProblemsToEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :assigned_problems, :int
  end
end
