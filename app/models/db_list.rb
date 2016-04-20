class DbList
	def initialize(obj,name,raw=nil)
		@obj = obj
		@name = name
		if raw[@name].present?
			@shadow = raw[@name]
		end
	end

	def all
		if @data.nil?
			if @shadow.nil?
				raise "not implemented"
			else
				@data = @obj.expand(@shadow)
			end
		end
		return @data
	end

	def set(to_id)
		@@db.command("UPDATE #{@obj.id} SET #{@name}=##{to_id}")
	end

	def add(to_id)
		@@db.command("UPDATE #{@obj.id} ADD #{@name}=##{to_id}")
	end

	def del
	end

	def include?(id)
	end

	def count
		#@@db.query("SELECT #{@name}.size() AS size FROM #{@obj.id}")
		if @shadow.present?
			return @shadow.count
		else
			return 0
		end
	end
end
