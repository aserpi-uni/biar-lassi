class AddActiveToEnterprise < ActiveRecord::Migration[5.1]
  def change
    add_column :enterprises, :active, :boolean, default: true
  end
end
