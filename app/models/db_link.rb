class DbLink
	def initialize(obj,name)
		@obj = obj
		@name = name
	end

	def load(raw)
		if raw[@name].present?
			@shadow = raw[@name]
		end
	end

	def get
		if @data.nil?
			if @shadow.nil?
				return nil
			else
				@data = Vertice::Vertice.find(@shadow.tr("#",""))
			end
		end
		return @data
	end

	def set(to_id)
		@@db.command("UPDATE #{@obj.id} SET #{@name}=##{to_id}")
	end

	def empty?()
		return @shadow.nil?
	end

	def del
		@@db.command("UPDATE #{@obj.id} SET #{@name}=''")
	end

	def include?(id)
	end
end
