class AddProductToAdviceThreads < ActiveRecord::Migration[5.1]
  def change
    add_reference :advice_threads, :product, foreign_key: true
  end
end
