class AddSolutionToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :solution, :boolean, default: false
  end
end
