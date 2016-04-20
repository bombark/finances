module Edge
	class Comments < Dbedge
		attr_accessor :text,:_from,:_to,:likes

		def initialize(id=nil)
			@links = DbLink.new(self,"likes")
		end

		def build(raw)
			super(raw)
			@text = raw["text"] || ""
		end

		def self.find(id)
			raw = @@db.get_document "##{id}"
			return Comments.new(raw)
		end

		######################## ARRUMAR PARA QUE O MESMO USUARIO NAO DEE varios curtirs
		def like(user_id)
			if !@likes.include?(user_id)
				raw = @@db.command "UPDATE ##{@id} ADD likes=##{user_id}"
			end
		end

		def self.create
			sql = "CREATE EDGE comments FROM ##{@_from} TO ##{@_to} SET text='#{@text}'"
			raw = @@db.command(sql)
			@id = raw["result"][0]["@rid"]
		end
	end
end
