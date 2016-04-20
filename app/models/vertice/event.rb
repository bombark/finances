class Vertice::Event < Vertice::Vertice
	attr_accessor :ini, :end, :acronym, :weburl
	attr_reader   :participants, :places, :owners

	def initialize()
		super()
		@owners   = DbIn.new(self,"hasEvent")
		@participants = DbOut.new(self,"hasUser")
		@places = DbOut.new(self,"localizedIn")
	end

	def build(raw)
		super(raw)
		@acronym = raw["acronym"] || ""
		@weburl = raw["weburl"]   || ""
		if raw["ini"].present?
			@ini = Date.parse( raw["ini"] )
		end
		if raw["end"].present?
			@end = Date.parse( raw["end"] )
		end
		return self
	end

	def self.count
		res = @@db.query "SELECT count(@rid) FROM Event"
		return res[0]["count"]
	end

	def create
		classe = classe || "Event"
		return super(classe, "")
	end

	def update
		raw = @@db.command "UPDATE ##{@id} SET name='#{@name}',acronym='#{@acronym}'"
	end


	def path
		return "/events/#{@id}"
	end
end
