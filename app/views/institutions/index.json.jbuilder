json.array!(@institutions) do |institution|
  json.extract! institution, :id, :name, :path, :path_thumbnail
end
