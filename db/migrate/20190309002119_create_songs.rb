class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :title
      t.string :artist
      t.text :body
      t.string :spotify_url

      t.timestamps
    end
  end
end
