class AddPageCountToSong < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :page_count, :integer
  end
end
