class Vertice::Log < Dbnode
	attr_accessor :description


	def build(raw)
		super(raw)
		@description = raw["description"] || ""
		return self
	end


	def create(classe,sql)
		sql += ","	if sql != ""
		sql += "description='#{description}'"
		return super(classe,sql)
	end
end
