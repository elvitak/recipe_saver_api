Rails.logger = Logger.new(STDOUT)

class Recipe < ApplicationRecord
  validates_presence_of :title
  has_many :instructions
  has_many :ingredients
  has_one_attached :image
  accepts_nested_attributes_for :instructions, :ingredients

  def image_serialized
    if !image.attached?
      nil
    elsif Rails.env.test?
      ActiveStorage::Blob.service.path_for(image.key)
    else
      begin
        image.url(expires_in: 1.hour, disposition: 'inline')
      rescue URI::InvalidURIError => e
        Rails.logger.warning('Error, probably invalid upload: ' + e.to_s)
        nil
      end
    end
  end
end
