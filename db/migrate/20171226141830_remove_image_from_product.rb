class RemoveImageFromProduct < ActiveRecord::Migration[5.1]
  def change
    remove_attachment :products, :image
  end
end
