json.extract! game, :id, :name, :year, :manufacturer, :notes, :is_active, :created_at, :updated_at
json.url game_url(game, format: :json)
json.likes game.likes.length
if game.photo
  json.image asset_path("#{game.photo.thumb}")
end
