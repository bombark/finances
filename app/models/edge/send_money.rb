module Edge
	class SendMoney < Dbedge
		attr_accessor :value, :description, :date, :finality


		def initialize()
			@finality = DbLink.new(self, "finality")
		end

		def build(raw)
			super(raw)
			@value = raw["value"] || 0
			@value = @value/100.0
			@description = raw["description"] || ""
			@date = ""
		end


		def self.all_in(obj)
			res = Array.new
			raw = @@db.query "SELECT FROM (SELECT expand(in_sendMoney) FROM ##{obj.id})"
			for node in raw
				obj = SendMoney.new
				obj.build(node)
				res.push( obj )
			end
			return res
		end

		def self.all_out(obj)
			res = Array.new
			raw = @@db.query "SELECT FROM (SELECT expand(out_sendMoney) FROM ##{obj.id})"
			for node in raw
				obj = SendMoney.new
				obj.build(node)
				res.push( obj )
			end
			return res
		end


		def self.find(id)
			sendmoney = SendMoney.new
			raw = @@db.get_document "##{id}"
			return sendmoney.build(raw)
		end

		def self.create(from, to, finality, _value, description)
			#value = _value.replace('.','').replace(',','')
			sql = "CREATE EDGE sendMoney FROM #%s TO #%s SET value=%d,description='%s',finality=#%s" % [from.id, to.id, _value, description, finality.id]
			raw = @@db.command(sql)
			@id = raw["result"][0]["@rid"]
		end
	end
end
