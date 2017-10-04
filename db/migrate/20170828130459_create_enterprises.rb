class CreateEnterprises < ActiveRecord::Migration[5.1]
  def change
    create_table :enterprises do |t|
      t.text :name
      t.text :nickname_suffix
      t.text :description
      t.text :headquarters
      t.date :founded
      t.text :website
      t.text :avatar
      t.text :icon
      t.text :avatar_operator
      t.text :avatar_supervisor

      t.timestamps
    end

    add_index :enterprises, :name, unique: true, length: 191
  end
end
