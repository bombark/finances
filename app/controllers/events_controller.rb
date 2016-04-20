class EventsController < ApplicationController
	def index
		respond_to do |format|
			format.html{
				@events = Vertice::Vertice.all("Event")
			}
			format.json{
				akk = params["akk"] || ""
				query = params[:q] || ""
				if akk == ""
					@events = Vertice::Vertice.all("Event",query)
				elsif akk == "myevents"
					@events = current_user.events.all
				end
			}
		end


	end

	def show
		@event = Vertice::Vertice.find(params[:id])
	end

	def new
	end

	def create
		event = Vertice::Event.new.build(params[:event])
		event.create
		current_user.events.add(event)
		redirect_to :back
	end

	def destroy
		event = Vertice::Vertice.find(params[:id])
		event.destroy
		redirect_to "/home"
	end

	def edit
		@event = Vertice::Vertice.find(params[:id])
	end

	def update
		event = Vertice::Event.new.build(params[:event])
		event.id = params[:id]
		event.update
		redirect_to event.path
	end


	def addparticipant
		@event = Vertice::Vertice.find(params[:id])
		@event.participants.add(current_user)
		redirect_to :back
	end


	def search
		if params[:akk] == "all"
			@objects = Vertice::Event.all("Event")
		end
		respond_to do |format|
			format.json
		end
	end



end
