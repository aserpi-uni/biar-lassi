class RemoveAdviceComments < ActiveRecord::Migration[5.1]
  def change
    drop_table :advice_comments
  end
end
