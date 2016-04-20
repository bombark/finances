module Vertice
	class Method < Vertice
		attr_accessor :code

		def build(raw)
			super(raw)
			@code  = raw["code"] || ""
			return self
		end

		def create(classe=nil,sql="")
            sql += ","	if sql != ""
            sql += "code='#{@width}'"
            classe = classe || "Method"
            return super(classe, sql)
        end

		def path
			return "/methods/#{@id}"
		end
	end
end
