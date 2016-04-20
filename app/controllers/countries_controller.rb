class CountriesController < ApplicationController
	def index
	end

	def show
		@country = Vertice::Vertice.find(params[:id])
		respond_to do |format|
			format.html
			format.json{
				akk = params["akk"] || ""
				query = params[:q] || ""
				if akk == "states"
					@objects = @country.states.all
				elsif akk == "universities"
					@objects = @country.universities.all
				end
			}
		end
	end

	def states
		country = Vertice::Vertice.find(params[:id])
		@states = country.states.all
		respond_to do |format|
			format.json
		end
	end
end
