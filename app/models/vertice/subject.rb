class Vertice::Subject < Vertice::Vertice

	attr_reader :about

	def initialize(id=nil)
		super(id)
		@about       = DbIn.new(self, "isAbout")
	end

	def create(classe=nil,sql="")
		classe = classe || "Subject"
		return super(classe, sql)
	end

	def self.count
		res = @@db.query "SELECT count(@rid) FROM Subject"
		return res[0]["count"]
	end

	def path
		return "/subjects/#{@id}"
	end
end
