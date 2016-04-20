class Vertice::Group < Vertice::Vertice
	attr_accessor :acronym
	attr_reader :members, :owners, :followers, :places, :projects, :groups, :events, :classes, :collections

	def initialize()
		@classe    ||= "Group"
		super()
		@members   = DbOut.new(self, "hasMember")
		@owners    = DbIn.new(self,  "hasGroup")
		@events    = DbOut.new(self, "hasEvent")
		@collections = DbOut.new(self, "hasCollection")
		@followers = DbIn.new(self, "followsGroup")
		@places    = DbOut.new(self, "localizedIn")
		@projects  = DbOut.new(self, "hasProject")
		@classes   = DbOut.new(self, "hasClasse")
	end

	def build(raw)
		super(raw)
		@acronym = raw["acronym"] || ""
		return self
	end

	def self.count
		res = @@db.query "SELECT count(@rid) FROM Group"
		return res[0]["count"]
	end


	def getSql(sql="")
		sql += ","	if sql != ""
		sql += "acronym='#{@acronym}'"
		return super(sql)
	end


	def destroy
		for group in self.sons.all
			group.destroy
		end
		super
	end

	def path
		return "/groups/#{id}"
	end

	def select(attr)
		if attr == "projects"
			return projects.all
		elsif attr == "collections"
			return collections.all
		elsif attr == "groups"
			return sons.all
		elsif attr == "members"
			return members.all
		elsif attr == "events"
			return events.all
		elsif attr == "classes"
			return classes.all
		else
			return []
		end
	end
end
