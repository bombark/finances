class Vertice::State < Vertice::Place

	def create(classe=nil,sql="")
		classe = classe || "State"
		return super(classe, sql)
	end

	def path
		return "/states/#{@id}"
	end
end
