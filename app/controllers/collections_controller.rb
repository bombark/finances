class CollectionsController < ApplicationController
	def index
		respond_to do |format|
			format.html{
				@collections = Vertice::Vertice.all("Collection")
			}
			format.json{
				akk = params["akk"] || ""
				query = params[:q] || ""
				if akk == ""
					@collections = Vertice::Vertice.all("Collection",query)
				elsif akk == "mycollections"
					@collections = current_user.collections.all
				end
			}
		end
	end

	def show
		@collection = Vertice::Vertice.find(params[:id])
	end

	def new

	end

	def create
		collection = Vertice::Collection.new.build(params[:collection])
		collection.create
		current_user.collections.add(collection)
		redirect_to collection.path
	end


	def addweb
		collection   = Vertice::Vertice.find(params[:id])
		weburl  = Vertice::Weburl.new.build(params[:weburl])
		weburl.create
		collection.dbox.add(weburl)

		weburl.set_publisher(current_user)


		redirect_to collection.path
	end


	def upload
		collection   = Vertice::Vertice.find(params[:id])
		dbox = Vertice::Dbox.build_by_name(params[:dbox], params[:dbox][:bitstream].original_filename)

		#aux = dbox.extract( params[:dbox][:bitstream] )
		#render text: aux
		dbox.create
		dbox.set_file( params[:dbox][:bitstream] )

		if dbox.class.name == "Vertice::Image" and collection.thumbnail == ""
			collection.thumbnail = dbox.thumbnail
		end


		collection.dbox.add(dbox)
		dbox.set_publisher(current_user)

		redirect_to :back
	end


	def addabout
		about = Vertice::Vertice.find(params[:about][:id])
		collection = Vertice::Vertice.find(params[:id])
		collection.about.add(about)
		redirect_to :back
	end

end
