class CreateUpVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :up_votes do |t|
      t.references :upper, polymorphic: true
      t.references :uppable, polymorphic: true
    end
  end
end
