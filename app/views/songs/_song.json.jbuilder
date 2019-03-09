json.extract! song, :id, :title, :artist, :body, :spotify_url, :created_at, :updated_at
json.url song_url(song, format: :json)
