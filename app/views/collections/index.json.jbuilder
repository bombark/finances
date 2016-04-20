json.array!(@collections) do |object|
  json.extract! object, :id, :name, :path, :path_thumbnail
end
