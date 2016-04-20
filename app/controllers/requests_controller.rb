class PlacesController < ApplicationController
	def index
		@places = Vertice::Vertice.all("Place")
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
