class Vertice::Country < Vertice::Place
	attr_accessor :universities
	attr_reader   :states, :about

	def build(raw)
		super(raw)
		@states       = DbOut.new(self,"hasSon")
		@universities = DbList.new(self,"universities",raw)
		@about        = DbIn.new(self,"isAbout")
		return self
	end


	#def states_count
	#	return out_count("has_subplaces")
	#end

	#def universities
	#	if @universities.nil?
	#		@universities = expand(@_universities)
	#	end
	#	return @universities
	#end

	#def universities_count
	#end

	def cities_count
		self.get_subplaces
		size = 0
		for state in @subplaces
			size += state.out_count("has_subplaces")
		end
		return size
	end


	def path
		return "/countries/#{@id}"
	end
end
