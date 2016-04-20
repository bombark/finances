class Vertice::Person < Vertice::Vertice

	attr_reader   :references

	def initialize()
		super()
		@references = DbIn.new(self,"isAbout")
	end

	def self.count
		res = @@db.query "SELECT count(@rid) FROM Person"
		return res[0]["count"]
	end

	def getSql(sql="")
		sql += ","	if sql != ""
		sql += "birth='',dead=''"
		return super(sql)
	end


	def path
		return "/persons/#{@id}"
	end
end
