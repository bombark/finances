class PeopleController < ApplicationController
	def index
		respond_to do |format|
			format.html{
				@persons = Vertice::Vertice.all("Person")
			}
			format.json{
				@objects = Vertice::Vertice.all("Person")
			}
		end
	end

	def show
		@person = Vertice::Vertice.find(params[:id])
	end

	def edit
		@person = Vertice::Vertice.find(params[:id])
	end

	def update
		person = Vertice::Person.new.build(params[:person])
		person.id = params[:id]
		person.update
		redirect_to person.path
	end




	def create
		person = Vertice::Person.new.build(params[:post_data])
		sql = person.create
		#render text: sql
		redirect_to person.path
	end

	def destroy
		@person = Vertice::Vertice.find(params[:id])
		@person.destroy
		redirect_to :back
	end


end
