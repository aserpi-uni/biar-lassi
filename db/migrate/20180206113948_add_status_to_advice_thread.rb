class AddStatusToAdviceThread < ActiveRecord::Migration[5.1]
  def change
    add_column :advice_threads, :status, :integer, default: 0
  end
end
