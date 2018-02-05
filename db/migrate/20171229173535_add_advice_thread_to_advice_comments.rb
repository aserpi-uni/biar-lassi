class AddAdviceThreadToAdviceComments < ActiveRecord::Migration[5.1]
  def change
    add_reference :advice_comments, :advice_thread, foreign_key: true
  end
end
