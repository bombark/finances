class LanguagesController < ApplicationController
	def index
		respond_to do |format|
			format.html{
				@languages = Vertice::Vertice.all("Language")
			}
			format.json{
				akk = params["akk"] || ""
				query = params[:q] || ""
				@languages = Vertice::Vertice.all("Language",query)
			}
		end
	end

	def show
		@language = Vertice::Vertice.find(params[:id])
	end

	def new

	end


	def create
		language = Vertice::Language.new.build(params[:place])
		language.create
	end




end
