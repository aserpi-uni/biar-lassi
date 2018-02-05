class RenameConsumerToAdviceThread < ActiveRecord::Migration[5.1]
  def change
    rename_column :advice_threads, :consumer_id, :author_id
  end
end
