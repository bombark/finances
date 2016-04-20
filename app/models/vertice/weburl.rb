class Vertice::Weburl < Vertice::Dbox
	attr_accessor :weburl

	def build(raw)
		super(raw)
		@weburl = raw["weburl"] || ""
		return self
	end

	def create(classe=nil,sql="")
		sql += ","	if sql != ""
		sql += "weburl='#{@weburl}'"
		classe = classe || "Weburl"
		super(classe,sql)
		return create_thumbnail
	end

	def create_thumbnail
		aux = URI.parse(@weburl)
		if aux.host == "www.youtube.com"
			params = CGI.parse(aux.query)
			if params["v"].present?
				self.set_thumbnail_by_weburl "http://img.youtube.com/vi/#{params["v"][0]}/0.jpg"
			end
		else
			# Cria o thumbnail (retirar toda a gambiarra)
			src = @weburl
			dst = self.filebox_thumbnail_url
			system("wkhtmltopdf.sh \"#{src}\" \"tmp.pdf\"")
			system("convert tmp.pdf[0] \"tmp.jpg\"")
			system("mv tmp.jpg \"#{dst}\"")
			self.thumbnail=@id
		end
	end

	def file_path
		return @weburl
	end

	def path
		return "/dbox/#{@id}"
	end
end
