class Recipe::IndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :image

  def image
    object.image_serialized
  end
end
