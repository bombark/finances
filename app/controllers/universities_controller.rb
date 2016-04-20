class UniversitiesController < ApplicationController
	def index
		respond_to do |format|
			format.html{
				@universities = Vertice::Vertice.all("University")
			}
			format.json{
				akk = params["akk"] || ""
				query = params[:q] || ""
				@universities = Vertice::Vertice.all("University",query)
			}
		end

	end

	def show
		@university = Vertice::Vertice.find(params[:id])
	end

end
