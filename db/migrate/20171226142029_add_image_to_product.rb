class AddImageToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :image_data, :string
  end
end
