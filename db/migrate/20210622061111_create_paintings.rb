class CreatePaintings < ActiveRecord::Migration[5.2]
  def change
    create_table :paintings do |t|
      t.string :image, null: false
      t.string :title, null: false
      t.string :date
      t.string :dimensions_text
      t.float :width
      t.float :height
      t.string :collecting_institution
      t.float :depth
      t.float :diameter
      t.string :slug
      t.integer :votes
      t.references :artist
    end
  end
end
