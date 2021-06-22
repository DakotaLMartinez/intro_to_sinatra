class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :name, null: false
      t.string :hometown
      t.string :birthday
      t.string :deathday
    end
  end
end
