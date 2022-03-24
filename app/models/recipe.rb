class Recipe < ApplicationRecord
  validates_presence_of :title
  has_many :instructions
  has_many :ingredients
  has_one_attached :image
  accepts_nested_attributes_for :instructions, :ingredients
end
