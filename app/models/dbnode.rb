class Dbnode
	attr_accessor :id, :classe
	attr_reader   :sons
	@@db = Neex::Application.database

	def initialize()
		@id = nil
		#if recursive == true
			@sons = DbOut.new(self,"hasSon")
		#end
	end

	def build(raw)
		if raw["rid"].present?
			@id = raw["rid"].tr("#","")
		elsif raw["@rid"].present?
			@id = raw["@rid"].tr("#","")
		end
		return self
	end

	def self.all(class_name, query="")
		if query == ""
			return Vertice::Vertice.search_orient(class_name)
		else
			return Vertice::Vertice.search_elastic(class_name,query)
		end
	end

	def self.find(id)
		if id.nil?
			raise "Id is nill"
		end
		raw = @@db.get_document "##{id}"
		cls = Object.const_get('Vertice').const_get( raw["@class"] )
		obj = cls.new
		obj.build(raw)
		return obj
	end

	def getSql(sql)
		return sql;
	end


	def create(sql)
		begin
			res = @@db.command "INSERT INTO #{@classe} SET #{sql}"
			@id = res["result"][0]["@rid"].tr("#","")
		rescue
			return "INSERT INTO #{@classe} SET #{sql}"
		end
	end

	def update (sql)
		if @id.nil?
			raise "Id is nil"
		end
		@@db.command "UPDATE ##{@id} SET #{sql}"
		return "UPDATE ##{@id} SET #{sql}"
	end


	def destroy
		if @id.nil?
			raise "Id is nil"
		end
		return @@db.command "DELETE VERTEX #{@id}"
	end




	def in(relation)
		app = Object.const_get('Vertice')
		res = Array.new
		raw = @@db.query "SELECT expand(out) FROM (SELECT expand(in_#{relation}) FROM ##{@id})"
		for node in raw
			cls = app.const_get( node["@class"] )
			obj = cls.new
			obj.build(node)
			res.push( obj )
		end
		return res
	end

	def in_count(relation)
		raw = @@db.query "SELECT in_#{relation}.size() AS size FROM ##{@id}"
		if raw[0]["size"].present?
			return raw[0]["size"]
		else
			return 0
		end
	end


	def out(relation)
		app = Object.const_get('Vertice')
		res = Array.new
		raw = @@db.query "SELECT expand(in) FROM (SELECT expand(out_#{relation}) FROM ##{@id})"
		for node in raw
			cls = app.const_get( node["@class"] )
			obj = cls.new
			obj.build(node)
			res.push( obj )
		end
		return res
	end

	def out_count(relation)
		raw = @@db.query "SELECT out_#{relation}.size() AS size FROM ##{@id}"
		if raw[0]["size"].present?
			return raw[0]["size"]
		else
			return 0
		end
	end






	def edges_in(relation)
		res = Array.new
		raw = @@db.query "SELECT expand(in_#{relation}) FROM ##{@id}"
		for node in raw
			edge = Dbedge.new
			edge.build(node)
			res.push( edge )
		end
		return res
	end

	def edges_out(relation)
		res = Array.new
		raw = @@db.query "SELECT expand(out_#{relation}) FROM ##{@id}"
		for node in raw
			edge = Dbedge.new
			edge.build(node)
			res.push( edge )
		end
		return res
	end


	def expand(ids, limit=20)
		res = []
		i = 0
		for id in ids
			res.push Vertice::Vertice.find(id.tr("#",""))
			i += 1
			if i >= limit
				break
			end
		end
		return res
	end




	def filebox_path
		return File.join(Rails.root, "files/nodes", @id)
	end

	def filebox_get(filename)
		return File.join(filebox_path, filename)
	end

	def filebox_add(filename, upload)
		path = filebox_path
		FileUtils::mkdir_p path
		url  = File.join(path, filename)
		File.open(url, "wb") do |f|
			f.write(upload.read)
		end
	end

	def filebox_thumbnail_url
		return File.join(Rails.root, "files/thumbnails", @id)
	end

	def filebox_destroy
		FileUtils.rm_rf File.join(filebox_path)
	end






	def mother
		@mother ||= self.in("hasSon").first || nil;
		return @mother
	end

	def mothers
		if @mothers.nil?
			@mothers = []
			ptr = self.mother
			while ptr.present?
				@mothers.push ptr
				ptr = ptr.mother
			end
		end
		return @mothers
	end



	def path
		raise "Not implemented"
	end




	def self.search_index(query)
		if query == ""
			query = "fogo"
		end

		raw =  Neex::Application.elastic.search ({
			index: 'neex',
			size: 20,
			body: {
				query: {
					match: { "name":query }
				}
			}
		})

		res = []
		for node in raw["hits"]["hits"]
			res.push( Dbnode.find(node["_id"].tr("#","")) )
		end
		return res
	end


private
	def self.search_orient(classe)
		if classe == ""
			raise "Class is Nil"
		end
		app = Object.const_get('Vertice')
		res = Array.new
		raw = @@db.query "SELECT FROM "+classe,{limit:-1}
		for node in raw
			cls = app.const_get( node["@class"] )
			obj = cls.new
			obj.build(node)
			res.push( obj )
		end
		return res
	end

	def self.search_elastic(classe,query)
		raw =  Neex::Application.elastic.search ({
			index: 'neex',
			size: 20,
			body: {
				query: {
					filtered: {
						query: {
							match: { "name":query }
						},
						filter: {
							type: { "value":classe }
						}
					}
				}
			}
		})

		res = []
		for node in raw["hits"]["hits"]
			res.push( Dbnode.find(node["_id"].tr("#","")) )
		end
		return res
	end





	def self.get_id_by_weburl(weburl)
		a = URI.parse(weburl)
		aux = a.path.split("/")
		if aux[2].present?
			return aux[2]
		else
			raise "No id"
		end
	end

end
