class Vertice::Collection < Vertice::Vertice

	attr_reader :followers, :follows, :publisher, :dbox, :about

	def initialize()
		@classe    ||= "Collection"
		super()
		@followers   = DbIn.new(self, "followsCollection")
		@dbox        = DbOut.new(self, "hasDbox")
		@about       = DbOut.new(self, "isAbout")
	end


	def publisher
		@publisher ||= self.in("hasCollection").first
		return @publisher
	end

	def self.count
		res = @@db.query "SELECT count(@rid) FROM Collection"
		return res[0]["count"]
	end


	def create
		classe = classe || "Collection"
		return super(classe, "")
	end

	def path
		return "/collections/#{id}"
	end
end
