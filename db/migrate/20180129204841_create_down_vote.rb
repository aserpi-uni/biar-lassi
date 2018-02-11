class CreateDownVote < ActiveRecord::Migration[5.1]
  def change
    create_table :down_votes do |t|
      t.references :downer, polymorphic: true
      t.references :downable, polymorphic: true
      t.text :reason
    end
  end
end
