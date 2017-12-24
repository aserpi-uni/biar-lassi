class Product < ApplicationRecord
  searchkick

  belongs_to :enterprise
  has_many :problem_threads, dependent: :destroy

  has_attached_file :image, styles: { medium: '200x300#' }, thumb: '100x100'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

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
