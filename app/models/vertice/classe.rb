module Vertice
	class Classe < Vertice

		attr_reader :methods

		def initialize(id=nil)
			super(id)
			@methods  = DbOut.new(self, "hasMethod")
		end

		def create
			classe = classe || "Classe"
			return super(classe, "")
		end

		def path
			return "/classes/#{@id}"
		end
	end
end
