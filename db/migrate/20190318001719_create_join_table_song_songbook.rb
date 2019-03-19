class CreateJoinTableSongSongbook < ActiveRecord::Migration[5.2]
  def change
    create_join_table :songbooks, :songs do |t|
      t.index [:songbook_id, :song_id]
      t.index [:song_id, :songbook_id]
    end
  end
end
