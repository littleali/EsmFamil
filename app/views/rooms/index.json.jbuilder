json.array!(@rooms) do |room|
  json.extract! room, :id, :name, :admin_id, :capacity, :enabled
  json.url room_url(room, format: :json)
end
