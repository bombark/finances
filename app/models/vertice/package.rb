class Vertice::Package < Vertice::Dbox

	def extract(upload)
		path = "files/tmp"
		FileUtils::mkdir_p path
		url = File.join(path, "package.tgz")
		File.open(url, "wb") do |f|
			f.write(upload.read)
		end


		system("tar xvf \"#{url}\" -C files/tmp/")
		aux = Dir.entries("files/tmp/einstein")

		for item in aux
			dbox = Vertice::Dbox.build_by_name({name:item},item)
			dbox.create
			dbox.mv_file File.join(path, "einstein", dbox.name)
		end


	end


end
