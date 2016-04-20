json.array!(@states) do |state|
  json.extract! state, :id, :name, :path, :thumbnail
end
