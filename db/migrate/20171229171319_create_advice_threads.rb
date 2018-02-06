class CreateAdviceThreads < ActiveRecord::Migration[5.1]
  def change
    create_table :advice_threads do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
