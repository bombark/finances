class Vertice::University < Vertice::Institution

	def create(classe=nil,sql="")
		classe = classe || "University"
		return super(classe, sql)
	end

	def self.count
		res = @@db.query "SELECT count(@rid) FROM University"
		return res[0]["count"]
	end

	def path
		return "/universities/#{@id}"
	end
end
