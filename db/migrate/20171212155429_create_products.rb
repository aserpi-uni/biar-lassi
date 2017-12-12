class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :model
      t.text :description
      t.integer :production_year

      t.timestamps
    end
  end
end
