class Ingredient::ShowSerializer < ActiveModel::Serializer
  attributes :id, :amount, :unit, :name
end
