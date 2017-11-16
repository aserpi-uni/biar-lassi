class RemoveIconFromEnterprise < ActiveRecord::Migration[5.1]
  def change
    remove_column :enterprises, :icon, :text
  end
end
