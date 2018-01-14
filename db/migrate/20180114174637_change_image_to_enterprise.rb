class ChangeImageToEnterprise < ActiveRecord::Migration[5.1]
  def change
    remove_column :enterprises, :avatar, :text
    remove_column :enterprises, :avatar_operator, :text
    remove_column :enterprises, :avatar_supervisor, :text

    add_column :enterprises, :image_data, :string
    add_column :enterprises, :avatar_operator_data, :string
    add_column :enterprises, :avatar_supervisor_data, :string
  end
end
