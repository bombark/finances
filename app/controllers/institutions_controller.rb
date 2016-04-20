class InstitutionsController < ApplicationController
	def index
		respond_to do |format|
			format.html{
				@institutions = Vertice::Vertice.all("Institution")
			}
			format.json{
				akk = params["akk"] || ""
				query = params[:q] || ""
				if akk == "universities"
					@institutions = Vertice::Vertice.all("University",query)
				else
					@institutions = Vertice::Vertice.all("Institution",query)
				end
			}
		end
	end

	def show
		@institution = Vertice::Vertice.find(params[:id])
	end

	def edit
		@institution = Vertice::Vertice.find(params[:id])
	end

	def create
		institution = Vertice::Institution.new.build(params[:institution])
		institution.create
		redirect_to institution.path
	end
end
