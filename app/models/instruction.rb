class Instruction < ApplicationRecord
  validates_presence_of :instruction
  belongs_to :recipe
end
