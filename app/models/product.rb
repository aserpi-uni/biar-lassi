class Product < ApplicationRecord
  include ImageUploader::Attachment.new(:image) # TODO: missing image
  searchkick

  belongs_to :enterprise
  has_many :problem_threads, dependent: :destroy

  validates :model, product_uniqueness: true

  # Blocks the products but not current problem threads
  def soft_delete
    self.active = false
    save
  end

  # Unblocks the product
  def soft_restore
    self.active = true
    save
  end
end
