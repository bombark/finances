class Vertice::Dbox < Vertice::Vertice
	attr_accessor :file, :extension
	attr_reader :about

	def initialize
		@about = DbOut.new(self, "isAbout")
	end


	def build(raw)
		super(raw)
		@file = raw["file"] || ""
		@extension = raw["extension"] || ""
		@_publisher = raw["publisher"] || nil
		return self
	end

	def publisher
		if @publisher.nil?
			@publisher = Vertice::Vertice.find(@_publisher.tr("#",""))
		end
		return @publisher
	end

	def set_publisher(obj)
		@@db.command("UPDATE ##{@id} SET publisher=##{obj.id}")
	end


	def create(classe=nil,sql="")
		sql += ","	if sql != ""
		sql += "file='#{@file}',extension='#{@extension}'"
		classe = classe || "Dbox"
		return super(classe, sql)
	end


	def self.build_by_name(raw, name)
		type = MIME::Types.type_for( name ).first.content_type
		aux  = type.split("/")
		classe = aux.first
		ext    = aux.last

		raw["extension"] = ext
		if classe=="image"
			return Vertice::Image.new.build(raw)
		elsif type=="application/pdf"
			return Vertice::Document.new.build(raw)
		#elsif type=="application/x-gtar"
		#	return Vertice::Package.new.build(raw)
		elsif type=="application/x-shockwave-flash"
			return Vertice::Animation.new.build(raw)
		else
			raise "File not supported"
		end
	end


	def destroy
		filebox_destroy
		super
	end


	def comments
		if @comments.nil?
			@comments = Array.new
			raw = @@db.query "SELECT expand(in_comments) FROM ##{@id}"
			for node in raw
				@comments.push( Edge::Comments.new(node) )
			end
		end
		return @comments
	end


#	def publisher
		#raise "ALTERAR AQUI"
		#@publisher ||= self.in("hasDbox").first
		#return @publisher
#	end


	def file_path
		return self.path+"/file"
	end

	def path
		return "/dbox/#{id}"
	end

	def set_thumbnail(upload)
		self.add_file("thumbnail", upload)
	end

	def set_file(upload)
		if @id.nil?
			raise "ID not defined"
		end
		type = MIME::Types.type_for( upload.original_filename ).first.content_type
		aux  = type.split("/")
		classe = aux.first
		ext    = aux.last

		name = SecureRandom.uuid+"."+ext;
		self.filebox_add(name, upload)
		@file = name

		@@db.command "UPDATE ##{@id} SET file='#{@file}'"
	end

	def get_file_path
		thumb = self.filebox_path
		return filebox_get(@file)
	end



end
