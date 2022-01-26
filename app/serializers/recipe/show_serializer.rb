class Recipe::ShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :ingredients, :instructions

  belongs_to :ingredients, serializer: Ingredient::ShowSerializer
  belongs_to :instructions, serializer: Instruction::ShowSerializer
end
