class CreateDirections < ActiveRecord::Migration[4.2]
  def change
    create_table :directions do |t|
      t.text :step
      t.belongs_to :recipe, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
