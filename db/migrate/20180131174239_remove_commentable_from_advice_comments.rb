class RemoveCommentableFromAdviceComments < ActiveRecord::Migration[5.1]
  def change
    remove_columns :advice_comments, :commentable_type
    remove_columns :advice_comments, :commentable_id
  end
end
