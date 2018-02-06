class AddDomainToComments < ActiveRecord::Migration[5.1]
  def change
    add_reference :comments, :domain, polymorphic: true
  end
end
