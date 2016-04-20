class DbIn
	def initialize(obj,name)
		@obj = obj
		@name = name
	end

	def all
		@data ||= @obj.in(@name);
		return @data
	end

	def add(from)
		Dbedge.create(@name,from.id,@obj.id)
	end

	def del
	end

	def count
		return @obj.in_count(@name)
	end
end
