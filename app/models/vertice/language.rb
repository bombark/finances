class Vertice::Language < Vertice::Subject

	def create(classe=nil,sql="")
		classe = classe || "Language"
		return super(classe, sql)
	end

	def self.count
		res = @@db.query "SELECT count(@rid) FROM Language"
		return res[0]["count"]
	end


	def path
		return "/subjects/#{@id}"
	end
end
