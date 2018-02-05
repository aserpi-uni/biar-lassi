class CreateAdviceComments < ActiveRecord::Migration[5.1]
  def change
    create_table :advice_comments do |t|
      t.text :content

      t.timestamps
    end
  end
end
