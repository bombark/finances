class Vertice::City < Vertice::Place

	def path
		return "/cities/#{@id}"
	end
end
