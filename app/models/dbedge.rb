class Dbedge < Dbnode

	def build(raw)
		super(raw)
		if raw["in"].present?
			@_to = raw["in"].tr("#","")
		elsif raw["to"].present?
			@_to = raw["to"].tr("#","")
		end
		if raw["out"].present?
			@_from = raw["out"].tr("#","")
		elsif raw["from"].present?
			@_from = raw["from"].tr("#","")
		end
		@to = nil
		@from = nil
	end

	def to
		@to ||= Vertice::Vertice.find(@_to)
		return @to
	end

	def from
		@from ||= Vertice::Vertice.find(@_from)
		return @from
	end

	def destroy
		@@db.command "DELETE EDGE ##{@id}"
	end


	def self.find_relation(relation, nom_id, akk_id)
		raw = @@db.query "SELECT FROM (SELECT expand(out_#{relation}) FROM ##{nom_id}) WHERE in=##{akk_id}"
		if raw[0].present?
			edge = Dbedge.new
			edge.build(raw[0])
			return edge
		else
			return nil
		end
	end


	def self.create(relation,from,to)
		if from.nil?
			raise "From id is Nil"
		end
		if to.nil?
			raise "To id is Nil"
		end
		raw = @@db.command "CREATE EDGE #{relation} FROM ##{from} TO ##{to}"

		edge = Dbedge.new
		edge.build(raw["result"][0])
		return edge
	end

	def self.find(id)
		raw = @@db.get_document "##{id}"
		edge = Dbedge.new
		edge.build(raw)
		return edge
	end
end
