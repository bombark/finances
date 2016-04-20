json.array!(@objects) do |object|
  json.extract! object, :id, :name, :path, :path_thumbnail
end
