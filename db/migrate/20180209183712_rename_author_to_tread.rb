class RenameAuthorToTread < ActiveRecord::Migration[5.1]
  def change
    rename_column :advice_threads, :author_id, :consumer_id
    rename_column :problem_threads, :author_id, :consumer_id
  end
end
