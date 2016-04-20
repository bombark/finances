class Vertice::Institution < Vertice::Vertice

	def create(classe=nil,sql="")
		classe = classe || "Institution"
		return super(classe, sql)
	end

	def self.count
		res = @@db.query "SELECT count(@rid) FROM Institution"
		return res[0]["count"]
	end

	def path
		return "/institutions/#{@id}"
	end
end
