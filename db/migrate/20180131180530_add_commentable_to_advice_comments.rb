class AddCommentableToAdviceComments < ActiveRecord::Migration[5.1]
  def change
    add_reference :advice_comments, :commentable, polymorphic: true
  end
end
