class DbOut
	def initialize(obj,name)
		@obj = obj
		@name = name
	end

	def all
		@data ||= @obj.out(@name);
		return @data
	end

	def all_in
		@in ||= @obj.in(@name)
		return @in
	end

	def all_inout
		if @inout.nil?
			@inout = @obj.in(@name)
			@inout.concat( @obj.out(@name) )
		end
		return @inout
	end


	def add(to)
		Dbedge.create(@name,@obj.id,to.id)
	end

	def del_by_to(to)
		edge = Dbedge.find_relation(@name, @obj.id, to.id)
		edge.destroy
	end

	def del(edge)
		edge.destroy
	end

	def count
		return @obj.out_count(@name)
	end

	def count_in
		return @obj.in_count(@name)
	end

	def exists?(to)
		if Dbedge.find_relation(@name, @obj.id, to.id) == nil
			return false
		else
			return true
		end
	end
end
