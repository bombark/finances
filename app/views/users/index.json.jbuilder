json.array!(@users) do |user|
  json.extract! user, :id, :name, :path, :path_thumbnail
end
