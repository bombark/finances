namespace :db do
	desc "Create geomaps file thought the shapes of countries in orientdb"
	task :maps do
		orientdb  = Neex::Application.database

		map_fd = File.open("files/geomaps.json",'w')
		map_fd.puts "{\"type\":\"FeatureCollection\",\"features\":["

		raw = orientdb.query("SELECT FROM Country WHERE shape <> ''",{:limit=>-1})

		if !raw.empty?
			rid = raw[0]["@rid"].tr("#","")
			map_fd.puts "{\"type\":\"Feature\",\"id\":\"#{rid}\",\"properties\":{\"name\":\"#{raw[0]["name"]}\"},\"geometry\":"
			map_fd.puts raw[0]["shape"]
			map_fd.puts "}\n"

			for i in 1..raw.count-1
				rid = raw[i]["@rid"].tr("#","")
				map_fd.puts ",{\"type\":\"Feature\",\"id\":\"#{rid}\",\"properties\":{\"name\":\"#{raw[i]["name"]}\"},\"geometry\":"
				map_fd.puts raw[i]["shape"]
				map_fd.puts "}\n"
			end
		end

		map_fd.puts "]}"
		map_fd.close
		puts "Criado formas para #{raw.count} paises"
	end
end
