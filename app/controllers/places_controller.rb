class PlacesController < ApplicationController
	def index
		query = params[:query] || ""
		@places = Vertice::Vertice.all("Place",query)


		respond_to do |format|
			format.html
			format.json
		end
	end

	def show
		@place = Vertice::Vertice.find(params[:id])
	end

	def new

	end


	def create
		place = Vertice::Place.new(params[:place])
		place.save()
	end



end
