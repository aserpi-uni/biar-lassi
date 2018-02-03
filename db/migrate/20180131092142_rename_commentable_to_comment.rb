class RenameCommentableToComment < ActiveRecord::Migration[5.1]
  def change
    rename_column :comments, :commentable_id, :author_id
    rename_column :comments, :commentable_type, :author_type
  end
end
