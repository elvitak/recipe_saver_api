class Recipe < ApplicationRecord
  validates_presence_of :title
  has_many :instructions
  has_many :ingredients
  has_one_attached :image
  accepts_nested_attributes_for :instructions, :ingredients

  def image_serialized
    if Rails.env.test?
      ActiveStorage::Blob.service.path_for(image.key)
    else
      image.url(expires_in: 1.hour,
                disposition: 'inline')
    end
  end
end
