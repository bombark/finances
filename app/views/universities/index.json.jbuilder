json.array!(@universities) do |university|
  json.extract! university, :id, :name, :path, :path_thumbnail
end
