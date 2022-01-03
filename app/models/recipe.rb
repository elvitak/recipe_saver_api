class Recipe < ApplicationRecord
  validates_presence_of :title
  has_many :instructions
  has_many :ingredients
end
