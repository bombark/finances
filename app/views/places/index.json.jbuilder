json.array!(@places) do |place|
  json.extract! place, :id, :name, :path, :thumbnail
end
