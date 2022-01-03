class Recipe < ApplicationRecord
  validates_presence_of :title
  has_many :instructions, inverse_of: :recipe
  has_many :ingredients, inverse_of: :recipe
end
