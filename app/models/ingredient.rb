class Ingredient < ApplicationRecord
  validates_presence_of :ingredient
  belongs_to :recipe
end
