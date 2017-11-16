class ChangeFoundedInEnterprise < ActiveRecord::Migration[5.1]
  def change
    remove_column :enterprises, :founded, :date
    add_column :enterprises, :founded, :int
  end
end
