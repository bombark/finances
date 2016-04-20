class Edge::LivesIn < DbOut
	def add(to)
		super(to)
		@@db.command "UPDATE ##{@id} SET lives_now=##{to.id}"
	end

	def now
	end
end
