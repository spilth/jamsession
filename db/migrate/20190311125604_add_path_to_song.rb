class AddPathToSong < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :path, :string
    add_index :songs, :path
  end
end
