class AddInstructionToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_reference :recipes, :instruction, null: false, foreign_key: true
  end
end
