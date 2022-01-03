class CreateIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients do |t|
      t.references :recipe, index: true, foreign_key: true

      t.integer :amount
      t.string :unit
      t.string :name

      t.timestamps
    end
  end
end
