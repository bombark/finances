class ShellController < ApplicationController
	def index
		@classe = params["name"]
		str = render_to_string('shared/mustache/_itemvert',:layout => false)
		render text: str
	end

	def actions
		res = ""
		#res.append( {"name"=>"template","text"=>"ini {{{main}}} end"} )
		#res.append( {"name"=>"item","text"=>render_to_string('shared/mustache/_itemvert',:layout => false)} )

		IO.popen "tiparser < teste.ti" do |io|
			res = io.read
		end

		render json: res
	end

	def forms
		classe = params["name"]
		#if classe=="Group"
			str = render_to_string("groups/_form",:layout => false);
		#end
		render text: str;
	end


	def list
		node = Vertice::Vertice.find(params[:id])
		list = node.select(params[:attr])

		res = []
		for obj in list
			res.append( {"name"=>obj.name,"url"=>obj.path,"thumbnail"=>obj.path_thumbnail,"class"=>obj.classe} )
		end
		render json: res.to_json()
	end
end
