class Vertice::Place < Vertice::Vertice
	attr_accessor :latitude, :longitude

	def build(raw)
		super(raw)
		@latitude  = raw["latitude"] || ""
		@longitude = raw["longitude"] || ""
		return self
	end

	def create(classe=nil,sql="")
		sql += ","	if sql != ""
		sql += "latitude='#{@latitude}',longitude='#{@longitude}'"
		classe = classe || "Place"
		return super(classe, sql)
	end


	def get_dwellers
		@dwellers ||= self.in("localizedIn");
		return @dwellers
	end


	def path
		return "/places/#{@id}"
	end
end
