# The representation of an Enterprise's product.
# Only Supervisors can create one, but Admins can update their fields.
# *Parameters:*
# * +active+ [Boolean]            it is possible to create new resources with the product
# * +description+ [String]        description of the product
# * +image+ [Shrine generated]    image of the product
# * +model+ [String]              name of the product
# * +production_year+ [Integer]   when the manufacture of the product started
#
# *Associations:*
# * +belongs_to+ [Enterprise]       the manufacturer
class Product < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
  searchkick callbacks: :async

  belongs_to :enterprise
  has_many :problem_threads, dependent: :destroy

  validates :model, product_uniqueness: true

  def update(attributes)
    old_image = image
    return false unless super(attributes)

    old_image.delete(:all) if old_image && old_image != image
    true
  end

  def search_data
    {
      model: model,
      enterprise: enterprise.name
    }
  end

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
