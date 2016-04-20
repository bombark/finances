class Vertice::Vertice < Dbnode
	attr_reader   :thumbnail
	attr_accessor :name, :description

	def build(raw)
		super(raw)
		@name        = raw["name"]        || ""
		@description = raw["description"] || ""
		@thumbnail   = raw["thumbnail"]   || ""
		return self
	end


	def create()
		return super(self.getSql)
	end

	def update()
		return super(self.getSql)
	end

	def getSql(sql="")
		sql += ","	if sql != ""
		sql += "name='#{@name}',description='#{@description}'"
		return super(sql)
	end


	def thumbnail=(name)
		@thumbnail = name
		@@db.command "UPDATE ##{@id} SET thumbnail='#{@thumbnail}'"
	end


	def set_thumbnail_by_upload(upload)
		File.open(self.filebox_thumbnail_url, "wb") do |f|
			f.write(upload.read)
		end
		self.thumbnail = "#{@id}"
	end

	def set_thumbnail_by_weburl(weburl)
		fd = File.open( self.filebox_thumbnail_url  ,"wb")
		fd.write(  Net::HTTP.get(URI.parse(weburl))  )
		fd.close
		self.thumbnail = "#{@id}"
	end


	def path
		raise "Not implemented"
	end

	def path_edit
		return path+"/edit"
	end

	def path_thumbnail
		if @thumbnail != ""
			return "/thumbnails/u/#{@thumbnail}"
		else
			return "/thumbnails/d/#{@classe}"
		end
	end
end
