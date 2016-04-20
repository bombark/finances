class Vertice::User < Vertice::Person
	attr_reader :collections, :followers, :events, :groups, :friends, :favorites, :finances

	def initialize()
		@classe    ||= "User"
		super()
		@collections = DbOut.new(self,"hasCollection")
		@followers   = DbOut.new(self,"followsUser")
		@favorites   = DbOut.new(self,"followsCollection")
		@groups      = DbOut.new(self,"hasGroup")
		@lives       = Edge::LivesIn.new(self,"localizedIn")
		@events      = DbOut.new(self,"hasEvent")
		@friends     = DbOut.new(self,"hasFriend")
	end

	def build(raw)
		super(raw)
		@email     = raw["email"] || ""
		@password  = raw["password"] || ""

		if raw["lives_now"].present?
			@_livesnow = raw["lives_now"].tr("#","")
		end
		return self
	end


	def self.find_by_email(email)
		raw = @@db.query "SELECT FROM User WHERE email='#{email}'"
		return Vertice::User.new.build(raw[0])
	end



	def getSql(sql="")
		sql += ","	if sql != ""
		sql += "email='#{@email}',password='#{@password}'"
		return super(sql)
	end


	def path
		return "/users/#{@id}"
	end

	def self.count
		res = @@db.query "SELECT count(@rid) FROM User"
		return res[0]["count"]
	end





	def requests
		@requests ||= self.edges_in("has_requests")
		return @requests
	end

	def has_requested(user_id)
		Dbedge.create("has_requests",@id,user_id)
	end

	def accepts_request(request)
		self.addfriend(request.from.id)
		request.destroy
	end

	def rejects_request(request)
		request.destroy
	end


	def comments(comment)
		comment._from = self.id;
		comment.save
	end

	def uncomments(comment)
		if comment._from == @id
			comment.destroy
		end
	end


	def places
		@places ||= self.edges_out("lives_in")
		return @places
	end

	def lives(place_id)
		Dbedge.create("lives_in",@id,place_id)
		@@db.command "UPDATE ##{@id} SET lives_now=##{place_id}"
	end



	def likes_comment(comment)
		comment.like(@id)
	end


	def lives_now
		if @_livesnow.present?
			return Vertice::Vertice.find(@_livesnow)
		end
		return nil
	end


	def self.all_online
		list = Dir.entries('files/users').select{|id|!File.directory? id}
		res = []
		for id in list
			res.push( Vertice::Vertice.find(id) )
		end
		return res
	end

	def set_online
		FileUtils::mkdir_p "files/users"
		fd = File.open("files/users/#{@id}","w");
		fd.puts DateTime.now.strftime('%s')
		fd.close
	end

	def is_online?
		return File.exists?("files/users/#{@id}")
	end

end
