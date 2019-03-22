class AddBuildingToSongs < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :building, :boolean
  end
end
