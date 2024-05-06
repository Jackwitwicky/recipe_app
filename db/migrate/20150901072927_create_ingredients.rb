class CreateIngredients < ActiveRecord::Migration[4.2]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.belongs_to :recipe, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
