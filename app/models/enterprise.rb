# The public profile of an enterprise.
# Only an Admin can create a new instance (and its first Employee, a supervisor).
# It is managed by the supervisors.
#
# *Parameters:*
# * +avatar_operator+ [Shrine generated]      default avatar for the operators
# * +avatar_supervisor+ [Shrine generated]    default avatar for the supervisors
# * +description+ [String]                    small of description of the enterprise
# * +founded+ [Date]                          the year the enterprise was founded
# * +headquarters+ [String]                   headquarters of the enterprise
# * +image+ [Shrine generated]                image of the enterprise
# * +name+ [String]                           the name of the enterprise
# * +username_suffix+ [String]                the username suffix of its employee
# * +website+ [String]                        enterprise's website
#
# *Associations:*
# * +has_many+ [Employee]   employees that work for the enterprise
# * +has_many+ [Product]    products of the enterprise
class Enterprise < ApplicationRecord
  include AvatarUploader::Attachment.new(:avatar_operator)
  include AvatarUploader::Attachment.new(:avatar_supervisor)
  include ImageUploader::Attachment.new(:image)

  validates :founded, numericality: { greater_than_or_equal_to: -4000, less_than_or_equal_to: 2500 }, allow_blank: true

  validates :name, format: { with: /\A[\w\s?!-]{3,64}\z/ }, reserved_name: true, uniqueness: { case_sensitive: false }

  validates :username_suffix, format: { with: /\A[\w\s?!-]{3,32}\z/ }, reserved_name: true,
                              uniqueness: { case_sensitive: false }

  has_many :employees, dependent: :destroy
  has_many :products, dependent: :destroy

  IMAGE_TYPES = %i[avatar_operator avatar_supervisor image].freeze

  def update(attributes)
    old_images = {}
    IMAGE_TYPES.each { |s| old_images[s] = send(s) }

    old_suffix = username_suffix
    old_name = name

    return false unless super(attributes)

    delete_images old_images

    products.find_each(&:reindex_async) if old_name != name

    update_suffix old_suffix
  end

  # Deletes images no more in use
  def delete_images(old_images)
    old_images.each do |name, image|
      image.delete(:all) if image && image != send(name)
    end
  end

  # Deletes all Employees and products
  def soft_delete
    self.active = false
    save

    employees.each(&:soft_delete)
    products.each(&:soft_delete)
  end

  def to_param
    name
  end

  # Changes employees' usarname
  def update_suffix(old_suffix)
    if old_suffix != username_suffix
      employees.find_each(&:update_suffix)
      employees.count
    else
      0
    end
  end
end
