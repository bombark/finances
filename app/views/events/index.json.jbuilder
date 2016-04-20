json.array!(@events) do |event|
  json.extract! event, :id, :name, :path, :path_thumbnail
end
