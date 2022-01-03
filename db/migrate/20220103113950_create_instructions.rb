class CreateInstructions < ActiveRecord::Migration[6.1]
  def change
    create_table :instructions do |t|
      t.references :recipe, index: true, foreign_key: true

      t.text :instruction

      t.timestamps
    end
  end
end
