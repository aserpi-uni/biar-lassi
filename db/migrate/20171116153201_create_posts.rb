class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :content
      t.references :consumer, foreign_key: true

      t.timestamps
    end
    add_index :posts, [:consumer_id, :created_at]
  end
end
