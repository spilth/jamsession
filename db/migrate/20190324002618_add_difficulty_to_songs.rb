class AddDifficultyToSongs < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :difficulty, :integer
  end
end
