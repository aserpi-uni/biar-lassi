class ChangeSuffixInEnterprise < ActiveRecord::Migration[5.1]
  def change
    rename_column :enterprises, :nickname_suffix, :username_suffix
  end
end
