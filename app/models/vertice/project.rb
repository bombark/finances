module Vertice
	class Project < Vertice
		def build(raw)
			obj = Project.new
			super(raw)
			return self
		end

		def create(classe=nil,sql="")
			classe = classe || "Project"
			return super(classe, sql)
		end


		def path
			return "/projects/#{@id}"
		end
	end
end
