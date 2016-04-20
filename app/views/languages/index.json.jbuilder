json.array!(@languages) do |language|
  json.extract! language, :id, :name, :path, :path_thumbnail
end
