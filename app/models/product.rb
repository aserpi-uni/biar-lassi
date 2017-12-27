# The representation of an Enterprise's product.
# Only Supervisors can create one, but Admins can update their fields.
# *Parameters:*
# * +active+ [Boolean]            it is possible to create new resources with the product
# * +description+ [String]        description of the product
# * +model+ [String]              name of the product
# * +production_year+ [Integer]   when the manufacture of the product started
#
# *Associations:*
# * +belongs_to+ [Enterprise]       the manufacturer
class Product < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
  # TODO: missing image
  # TODO: delete image
  searchkick

  belongs_to :enterprise
  has_many :problem_threads, dependent: :destroy

  validates :model, product_uniqueness: true

  # Locks the products but not current problem threads
  def soft_delete
    self.active = false
    save
  end

  # Unlocks the product
  def soft_restore
    self.active = true
    save
  end
end
