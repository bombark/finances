json.array!(@subjects) do |subject|
  json.extract! subject, :id, :name, :path, :path_thumbnail
end
