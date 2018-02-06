class AddConsumerToAdviceThreads < ActiveRecord::Migration[5.1]
  def change
    add_reference :advice_threads, :consumer, foreign_key: true
  end
end
