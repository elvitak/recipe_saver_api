Rails.logger = Logger.new(STDOUT)

class Recipe < ApplicationRecord
  validates_presence_of :title
  has_many :instructions
  has_many :ingredients
  has_one_attached :image
  accepts_nested_attributes_for :instructions, :ingredients

  def image_serialized
    Rails.logger.info('record: ' + attributes.to_s)
    Rails.logger.info('image data: ' + image.to_s)
    Rails.logger.info('Image.attached?: ' + image.attached?.to_s)
    if !image.attached?
      nil
    elsif Rails.env.test?
      ActiveStorage::Blob.service.path_for(image.key)
    else
      image.url(expires_in: 1.hour, disposition: 'inline')
    end
  end
end
